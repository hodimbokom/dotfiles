return {
	'lewis6991/gitsigns.nvim',
	config = function()
		require('gitsigns').setup({
			signs_staged_enable = true,
			on_attach = function(bufnr)
				local gitsigns = require('gitsigns')

				local function map(mode, l, r, opts)
					opts = opts or {}
					opts.buffer = bufnr
					vim.keymap.set(mode, l, r, opts)
				end

				map('n', ']c', function()
					if vim.wo.diff then
						vim.cmd.normal({ ']c', bang = true })
					else
						gitsigns.nav_hunk('next')
					end
				end)

				map('n', '[c', function()
					if vim.wo.diff then
						vim.cmd.normal({ '[c', bang = true })
					else
						gitsigns.nav_hunk('prev')
					end
				end)

				map('n', '<leader>hp', gitsigns.preview_hunk)
				map('n', '<leader>hb', function()
					gitsigns.blame_line({ full = true })
				end)
				map('n', '<leader>tb', gitsigns.toggle_current_line_blame)
				map('n', '<leader>td', gitsigns.toggle_deleted)
			end,
		})
	end,
}
