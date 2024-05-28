return {
  {
    "nvim-telescope/telescope.nvim",
    tag = "0.1.7",
    dependencies = {
      "nvim-lua/plenary.nvim",
      {
        "nvim-telescope/telescope-fzf-native.nvim",
        build = "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build",
      },
    },
    opts = {
      extensions_list = { "fzf" },
    },
    config = function()
      require("telescope").setup {
        defaults = {
          dynamic_preview_title = true,
          results_title = false,
          path_display = { "truncate" },
          file_ignore_patters = { "node_modules", ".git/" },
          layout_strategy = "vertical",
          layout_config = {
            vertical = {
              height = 0.8,
              width = 0.8,
              mirror = false,
              prompt_position = "bottom",
              preview_cutoff = 20,
            },
          },
        },
        pickers = {
          find_files = { prompt_title = false },
          git_files = { prompt_title = false, hidden = true },
        },
      }
      local builtin = require('telescope.builtin')

      vim.keymap.set({'n', 'i', 'v'}, '<C-p>', builtin.find_files, {})
      vim.keymap.set('n', '<leader>f', builtin.git_files, {})
      vim.keymap.set('n', '<leader>h', builtin.help_tags, {})

      vim.keymap.set('n', '<leader>ps', function()
        builtin.grep_string({ search = vim.fn.input("Grep > ") })
      end)

      require("telescope").load_extension("fzf")
    end
  },
}

