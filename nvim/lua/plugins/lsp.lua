return {
  {
    'neovim/nvim-lspconfig',
    dependencies = {
      'williamboman/mason.nvim',
      'williamboman/mason-lspconfig.nvim',
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-buffer',
      'hrsh7th/cmp-path',
      'hrsh7th/cmp-cmdline',
      'hrsh7th/nvim-cmp',
      'L3MON4D3/LuaSnip',
      'saadparwaiz1/cmp_luasnip',
      'j-hui/fidget.nvim',
    },
    config = function()
      local cmp = require('cmp')
      local cmp_lsp = require('cmp_nvim_lsp')
      local capabilities =
          vim.tbl_deep_extend('force', {}, vim.lsp.protocol.make_client_capabilities(), cmp_lsp.default_capabilities())

      vim.api.nvim_create_autocmd('LspAttach', {
        group = vim.api.nvim_create_augroup('lsp_config', {}),
        callback = function(ev)
          local opts = { buffer = ev.buf }

          vim.keymap.set('n', '<space>e', vim.diagnostic.open_float, opts)
          vim.keymap.set('n', '[g', vim.diagnostic.goto_prev, opts)
          vim.keymap.set('n', ']g', vim.diagnostic.goto_next, opts)
          vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
          vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
        end,
      })

      require('fidget').setup()
      require('mason').setup()

      local function find_tsserver(root)
        local function at(dir)
          if not dir or dir == '' then return nil end
          local path = dir .. '/node_modules/typescript/lib/tsserver.js'
          if vim.fn.filereadable(path) == 1 then return path end
        end

        local found = at(root)
        if found then return found end

        local git = vim.fn.systemlist({
          'git',
          '-C',
          root or vim.fn.getcwd(),
          'rev-parse',
          '--path-format=absolute',
          '--git-common-dir',
        })[1]
        if vim.v.shell_error == 0 and git then
          local from_main = at(vim.fn.fnamemodify(git, ':h'))
          if from_main then return from_main end
        end

        local mason = vim.fn.stdpath('data')
          .. '/mason/packages/typescript-language-server/node_modules/typescript/lib/tsserver.js'
        if vim.fn.filereadable(mason) == 1 then return mason end
      end

      vim.lsp.config('lua_ls', {
        capabilities = capabilities,
        settings = {
          Lua = {
            diagnostics = { globals = { 'vim', 'it', 'describe', 'before_each', 'after_each' } },
          },
        },
      })

      vim.lsp.config('ts_ls', {
        capabilities = capabilities,
        init_options = {
          hostInfo = 'neovim',
          tsserver = {
            path = find_tsserver(vim.fn.getcwd()),
            fallbackPath = vim.fn.stdpath('data')
              .. '/mason/packages/typescript-language-server/node_modules/typescript/lib/tsserver.js',
          },
        },
        on_attach = function(client, _)
          client.server_capabilities.documentFormattingProvider = false
          client.server_capabilities.documentRangeFormattingProvider = false
        end,
      })

      require('mason-lspconfig').setup({
        ensure_installed = { 'lua_ls', 'ts_ls', 'marksman' },
      })

      local cmp_select = { behavior = cmp.SelectBehavior.Select }

      cmp.setup({
        snippet = {
          expand = function(args)
            require('luasnip').lsp_expand(args.body)
          end,
        },

        window = {
          completion = cmp.config.window.bordered(),
          documentation = cmp.config.window.bordered(),
        },

        mapping = cmp.mapping.preset.insert({
          ['<C-k>'] = cmp.mapping.select_prev_item(cmp_select),
          ['<C-j>'] = cmp.mapping.select_next_item(cmp_select),
          ['<C-Space>'] = cmp.mapping.complete(),
          ['<C-i>'] = cmp.mapping.confirm({ select = true }),
          ['<C-p>'] = cmp.config.disable,
        }),

        sources = cmp.config.sources({
          { name = 'nvim_lsp' },
          { name = 'luasnip' },
          { name = 'buffer' },
        }),
      })

      vim.diagnostic.config({
        float = {
          focusable = false,
          style = 'minimal',
          border = 'rounded',
          source = 'always',
          header = '',
          prefix = '',
        },
      })
    end,
  },
}
