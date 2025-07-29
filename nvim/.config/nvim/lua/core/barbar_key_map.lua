local map = vim.keymap.set
local opts = { noremap = true, silent = true }

-- Move to previous/next buffer
map("n", "<leader>b<", "<Cmd>BufferPrevious<CR>", { desc = "Go to previous buffer" })
map("n", "<leader>b>", "<Cmd>BufferNext<CR>", { desc = "Go to next buffer" })

-- Re-order buffer to previous/next position
map("n", "<leader>bM<", "<Cmd>BufferMovePrevious<CR>", { desc = "Move buffer to previous position" })
map("n", "<leader>bM>", "<Cmd>BufferMoveNext<CR>", { desc = "Move buffer to next position" })

-- Go to buffer in specific position
map("n", "<leader>b1", "<Cmd>BufferGoto 1<CR>", { desc = "Go to buffer 1" })
map("n", "<leader>b2", "<Cmd>BufferGoto 2<CR>", { desc = "Go to buffer 2" })
map("n", "<leader>b3", "<Cmd>BufferGoto 3<CR>", { desc = "Go to buffer 3" })
map("n", "<leader>b4", "<Cmd>BufferGoto 4<CR>", { desc = "Go to buffer 4" })
map("n", "<leader>b5", "<Cmd>BufferGoto 5<CR>", { desc = "Go to buffer 5" })
map("n", "<leader>b6", "<Cmd>BufferGoto 6<CR>", { desc = "Go to buffer 6" })
map("n", "<leader>b7", "<Cmd>BufferGoto 7<CR>", { desc = "Go to buffer 7" })
map("n", "<leader>b8", "<Cmd>BufferGoto 8<CR>", { desc = "Go to buffer 8" })
map("n", "<leader>b9", "<Cmd>BufferGoto 9<CR>", { desc = "Go to buffer 9" })
map("n", "<leader>b0", "<Cmd>BufferLast<CR>", { desc = "Go to last buffer" })

-- Pin/unpin buffer
map("n", "<leader>bp", "<Cmd>BufferPin<CR>", { desc = "Pin/unpin buffer" })

-- Close buffer
map("n", "<leader>bd", "<Cmd>BufferClose<CR>", { desc = "Close current buffer" })

-- Magic buffer-picking mode
map("n", "<leader>b<space>p", "<Cmd>BufferPick<CR>", { desc = "Pick buffer" })

-- Sort buffers automatically by...
map("n", "<Space>bb", "<Cmd>BufferOrderByBufferNumber<CR>", { desc = "Sort buffers by number" })
map("n", "<Space>bn", "<Cmd>BufferOrderByName<CR>", { desc = "Sort buffers by name" })
map("n", "<Space>bd", "<Cmd>BufferOrderByDirectory<CR>", { desc = "Sort buffers by directory" })
map("n", "<Space>bl", "<Cmd>BufferOrderByLanguage<CR>", { desc = "Sort buffers by language" })
map("n", "<Space>bw", "<Cmd>BufferOrderByWindowNumber<CR>", { desc = "Sort buffers by window number" })
