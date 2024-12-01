local map = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }

-- Set leader key to space
vim.g.mapleader = " "

-- Better window navigation
map("n", "<C-h>", "<C-w>h", opts)
map("n", "<C-j>", "<C-w>j", opts)
map("n", "<C-k>", "<C-w>k", opts)
map("n", "<C-l>", "<C-w>l", opts)

-- Save file
map("n", "<leader>w", ":w<CR>", opts)

-- Quit
map("n", "<leader>q", ":q<CR>", opts)

-- No highlight
map("n", "<leader>h", ":noh<CR>", opts)

-- Explorer
map("n", "<leader>e", ":Lexplore 30<CR>", opts)
