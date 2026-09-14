return {
  {
    "rose-pine/neovim",
    name = "rose-pine",
    lazy = false,
    priority = 1000,
    config = function()
      require("rose-pine").setup {
        variant = "moon",
        enable = { terminal = true },
        styles = { bold = true, italic = false, transparency = true },

        disable_background = true,
        dim_inactive_windows = false,

        palette = {
          moon = { text = "#b4b1c8" },
        },

        highlight_groups = {
          Number = { fg = "rose" },
          Float = { fg = "rose" },
          Boolean = { fg = "love" },
          ["@number"] = { fg = "rose" },
          ["@number.float"] = { fg = "rose" },
          ["@boolean"] = { fg = "love" },
          ["@string.escape"] = { fg = "love" },
          ["@string.regexp"] = { fg = "iris" },
          ["@string.special"] = { fg = "foam" },

          ["@keyword.return"] = { fg = "love" },
          ["@keyword.exception"] = { fg = "love" },
          ["@keyword.debug"] = { fg = "love" },
          ["@keyword.import"] = { fg = "iris" },
          ["@keyword.export"] = { fg = "iris" },
          ["@keyword.coroutine"] = { fg = "iris" },
          ["@keyword.operator"] = { fg = "pine" },
          ["@keyword.type"] = { fg = "foam" },
          ["@keyword.modifier"] = { fg = "pine" },
          ["@keyword.function"] = { fg = "pine" },

          ["@type"] = { fg = "foam" },
          ["@type.builtin"] = { fg = "love" },
          ["@constructor"] = { fg = "gold" },
          ["@property"] = { fg = "iris" },
          ["@variable.member"] = { fg = "iris" },
          ["@variable.parameter"] = { fg = "iris" },
          ["@variable.builtin"] = { fg = "love" },
          ["@module"] = { fg = "iris" },
          ["@module.builtin"] = { fg = "iris" },
          ["@namespace"] = { fg = "iris" },
          ["@attribute"] = { fg = "gold" },
          ["@constant.builtin"] = { fg = "love" },

          ["@function"] = { fg = "rose" },
          ["@function.call"] = { fg = "rose" },
          ["@function.builtin"] = { fg = "love" },
          ["@function.macro"] = { fg = "iris" },
          ["@function.method"] = { fg = "rose" },
          ["@function.method.call"] = { fg = "iris" },

          Operator = { fg = "pine" },
          ["@operator"] = { fg = "pine" },
          ["@punctuation.delimiter"] = { fg = "muted" },
          ["@punctuation.bracket"] = { fg = "subtle" },
          ["@punctuation.special"] = { fg = "foam" },

          ["@tag"] = { fg = "rose" },
          ["@tag.builtin"] = { fg = "pine" },
          ["@tag.attribute"] = { fg = "iris" },
          ["@tag.delimiter"] = { fg = "muted" },

          ["@lsp.type.class"] = { fg = "foam" },
          ["@lsp.type.interface"] = { fg = "foam" },
          ["@lsp.type.enum"] = { fg = "foam" },
          ["@lsp.type.enumMember"] = { fg = "gold" },
          ["@lsp.type.type"] = { fg = "foam" },
          ["@lsp.type.typeParameter"] = { fg = "iris" },
          ["@lsp.type.decorator"] = { fg = "gold" },
          ["@lsp.type.namespace"] = { fg = "iris" },
          ["@lsp.type.parameter"] = { fg = "iris" },
          ["@lsp.type.property"] = { fg = "iris" },
          ["@lsp.type.event"] = { fg = "love" },
          ["@lsp.typemod.variable.unused"] = { fg = "muted" },
          ["@lsp.typemod.parameter.unused"] = { fg = "muted" },
          ["@lsp.typemod.variable.defaultLibrary"] = { fg = "love" },
          ["@lsp.typemod.function.defaultLibrary"] = { fg = "love" },
        },
      }

      vim.cmd.colorscheme "rose-pine-moon"

      for _, group in ipairs({
        "DiagnosticUnderlineError",
        "DiagnosticUnderlineWarn",
        "DiagnosticUnderlineInfo",
        "DiagnosticUnderlineHint",
        "DiagnosticUnderlineOk",
        "SpellBad",
        "SpellCap",
        "SpellLocal",
        "SpellRare",
      }) do
        local hl = vim.api.nvim_get_hl(0, { name = group, link = false })
        hl.undercurl = false
        hl.underline = true
        vim.api.nvim_set_hl(0, group, hl)
      end
    end,
  },
}
