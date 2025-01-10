-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

-- turn off swapfile
vim.opt.swapfile = false

-- Tabs & indentation
vim.opt.tabstop = 4
vim.opt.expandtab = true
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.autoindent = true

vim.g.snacks_animate = false
vim.lsp.inlay_hint.enable = false
vim.api.nvim_create_autocmd("BufEnter", { command = [[set formatoptions-=cro]] }) -- Disables automatic comment continuation on new lines
