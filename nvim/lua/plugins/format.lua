return {
	'stevearc/conform.nvim',
	event = { 'BufReadPre', 'BufNewFile' },
	config = function()
		local conform = require('conform')
		local on_save = { lsp_fallback = true, async = false, timeout_ms = 500 }

		conform.setup({
			formatters_by_ft = {
				javascript = { 'prettier' },
				typescript = { 'prettier' },
				javascriptreact = { 'prettier' },
				typescriptreact = { 'prettier' },
				css = { 'prettier' },
				html = { 'prettier' },
				json = { 'prettier' },
				yaml = { 'prettier' },
				markdown = { 'prettier' },
				graphql = { 'prettier' },
				lua = { 'stylua' },
			},
			format_on_save = on_save,
		})

		vim.keymap.set({ 'n', 'v' }, '<leader>mp', function()
			conform.format(on_save)
		end)
	end,
}
