vim.opt.shell = '/bin/zsh'

vim.opt.guicursor = ""
vim.opt.nu = true
vim.opt.rnu = true

vim.opt.smartindent = true
vim.opt.autoindent = true
vim.opt.breakindent = true

vim.opt.wrap = false

vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.opt.smarttab = true

vim.opt.scrolloff = 8

vim.opt.hlsearch = true
vim.opt.incsearch = true

vim.opt.signcolumn = "yes:1"
vim.opt.cursorline = true
vim.opt.termguicolors = true

vim.diagnostic.config({ underline = false })

local function strip_underline_color()
  for _, name in ipairs(vim.fn.getcompletion("", "highlight")) do
    local hl = vim.api.nvim_get_hl(0, { name = name, link = false })
    if hl.sp or hl.undercurl or hl.underdouble or hl.underdotted or hl.underdashed then
      hl.sp = nil
      hl.undercurl = false
      hl.underdouble = false
      hl.underdotted = false
      hl.underdashed = false
      vim.api.nvim_set_hl(0, name, hl)
    end
  end
end

vim.api.nvim_create_autocmd({ "ColorScheme", "VimEnter" }, { callback = strip_underline_color })
