return {
  {
    "nvim-treesitter/nvim-treesitter",
    branch = "main",
    lazy = false,
    build = ":TSUpdate",

    config = function()
      local treesitter = require("nvim-treesitter")

      treesitter.setup({})

      treesitter.install({
        "bash",
        "zsh",
        "lua",
        "javascript",
        "typescript",
        "tsx",
        "c",
        "vimdoc",
        "python",
        "go",
        "rust",
        "css",
        "html",
        "toml",
        "ini",
        "yaml",
        "tmux",
      })

      local group = vim.api.nvim_create_augroup(
        "TreesitterConfig",
        { clear = true }
      )

      vim.api.nvim_create_autocmd(
        { "BufNewFile", "BufRead" },
        {
          group = group,
          pattern = "*.conf",
          callback = function()
            vim.bo.filetype = "tmux"
          end,
        }
      )

      vim.api.nvim_create_autocmd("FileType", {
        group = group,
        pattern = {
          "sh",
          "bash",
          "zsh",
          "lua",
          "javascript",
          "javascriptreact",
          "typescript",
          "typescriptreact",
          "c",
          "help",
          "python",
          "go",
          "rust",
          "css",
          "html",
          "toml",
          "dosini",
          "yaml",
          "tmux",
        },

        callback = function(args)
          pcall(vim.treesitter.start, args.buf)

          vim.bo[args.buf].indentexpr =
            "v:lua.require'nvim-treesitter'.indentexpr()"
        end,
      })
    end,
  },
}
