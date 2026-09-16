vim.g.mapleader = " "

vim.keymap.set("i", "<C-c>", "<Esc>")

vim.keymap.set("n", "<leader>w", "<cmd>w<cr><esc>")

vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")

vim.keymap.set("n", "<leader>gg", function()
	if not vim.env.TMUX then
		vim.cmd("tabnew | terminal lazygit")
		return
	end
	vim.fn.jobstart({
		"tmux",
		"display-popup",
		"-d",
		vim.fn.getcwd(),
		"-E",
		"-h",
		"90%",
		"-w",
		"90%",
		"-T",
		"lazygit",
		"lazygit",
	}, { detach = true })
end)
