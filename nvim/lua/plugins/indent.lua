return {
  { 
    "lukas-reineke/indent-blankline.nvim", 
    main = "ibl",
    config = function()

      local hooks = require "ibl.hooks"

      hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
        vim.api.nvim_set_hl(0, "scope", { fg = "#eb6f92" })
        vim.api.nvim_set_hl(0, "indent", { fg = "#44415a" })
      end)

      require("ibl").setup { 
        indent = {
          char = "▏",
          highlight = { "indent" },
        }, 
        whitespace = {
          remove_blankline_trail = true,
        },
        scope = { highlight = { "scope" }, },
      }

      hooks.register(hooks.type.SCOPE_HIGHLIGHT, hooks.builtin.scope_highlight_from_extmark)
    end
  }
}
