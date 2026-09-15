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

        before_highlight = function(_, highlight)
          highlight.undercurl = false
          highlight.underdouble = false
          highlight.underdotted = false
          highlight.underdashed = false
          highlight.sp = nil
        end,

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

          DiagnosticUnderlineError = { underline = true, inherit = false },
          DiagnosticUnderlineWarn = { underline = true, inherit = false },
          DiagnosticUnderlineInfo = { underline = true, inherit = false },
          DiagnosticUnderlineHint = { underline = true, inherit = false },
          DiagnosticUnderlineOk = { underline = true, inherit = false },
          SpellBad = { underline = true, inherit = false },
          SpellCap = { underline = true, inherit = false },
          SpellLocal = { underline = true, inherit = false },
          SpellRare = { underline = true, inherit = false },
        },
      }

      vim.cmd.colorscheme "rose-pine-moon"
    end,
  },
}
