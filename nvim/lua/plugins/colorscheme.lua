return {
	{
    "rose-pine/neovim",
    lazy = false,
    priority = 1000,
    config = function()
      require("rose-pine").setup {
        enable = { terminal = true },
        styles = { bold = true, italic = false, transparency = true },

        disable_background = true,
        dim_inactive_windows = false,
      }

      vim.cmd.colorscheme "rose-pine-moon"
    end
	}
}
