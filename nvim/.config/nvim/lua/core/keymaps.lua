-- Set leader key to space
vim.g.mapleader = " "

local map = vim.keymap.set
local opts = { noremap = true, silent = true }

-- Better window navigation
map("n", "<C-h>", "<C-w>h", opts)
map("n", "<C-j>", "<C-w>j", opts)
map("n", "<C-k>", "<C-w>k", opts)
map("n", "<C-l>", "<C-w>l", opts)

-- Save file
map("n", "<leader>w", ":w<CR>", { desc = "Save file" })

-- Quit
map("n", "<leader>q", ":q<CR>", { desc = "Quit" })

-- No highlight
map("n", "<leader>h", ":noh<CR>", { desc = "Clear search highlight" })

-- NvimTree
map("n", "<leader>e", ":NvimTreeToggle<CR>", { desc = "Toggle NvimTree" })

-- Check LSP status
map("n", "<leader>ls", function()
    print(vim.inspect(vim.lsp.buf_get_clients()))
end, { desc = "LSP: Show attached clients" })