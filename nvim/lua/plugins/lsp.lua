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

			vim.lsp.handlers['textDocument/hover'] = vim.lsp.with(vim.lsp.handlers.hover, {
				border = 'rounded',
			})

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
			require('mason-lspconfig').setup({

				ensure_installed = { 'lua_ls', 'ts_ls', 'marksman' },

				handlers = {
					function(server_name)
						require('lspconfig')[server_name].setup({ capabilities = capabilities })
					end,

					['lua_ls'] = function()
						local lspconfig = require('lspconfig')
						lspconfig.lua_ls.setup({
							capabilities = capabilities,
							settings = {
								Lua = {
									diagnostics = { globals = { 'vim', 'it', 'describe', 'before_each', 'after_each' } },
								},
							},
						})
					end,

					['ts_ls'] = function()
						local lspconfig = require('lspconfig')
						lspconfig.ts_ls.setup({
							capabilities = capabilities,
							on_attach = function(client, _)
								client.server_capabilities.documentFormattingProvider = false
								client.server_capabilities.documentRangeFormattingProvider = false
							end,
						})
					end,
				},
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
