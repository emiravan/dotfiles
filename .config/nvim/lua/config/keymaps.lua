-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local map = vim.keymap.set

-- Redefine default paste in visual mode (x mode) to paste without yanking selected text
map("x", "p", [["_dP]])

-- Move selected lines up/down in visual mode
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- Join lines and return to original cursor position
vim.keymap.set("n", "J", "mzJ`z")

-- Center cursor while scrolling
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")

-- Center cursor while searching
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

-- Center cursor while shift+g
vim.keymap.set("n", "G", "Gzz")

-- Add new line above/below without switching to insert mode
map("n", "<CR>", "o<Esc>")
map("n", "<S-CR>", "O<Esc>")
