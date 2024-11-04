require("nvchad.mappings")

-- Scroll while keeping the cursor centered
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

-- Add new line above/below without switching to insert mode
map("n", "<CR>", "o<Esc>")
map("n", "<S-CR>", "O<Esc>")

-- Search and replace the word under cursor throughout the file
vim.keymap.set(
    "n",
    "<leader>s",
    [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]]
)

vim.keymap.set(
    "n",
    "<leader>q",
    'ciw""<Esc>P',
    { desc = "Word Surround Quotes" }
)
