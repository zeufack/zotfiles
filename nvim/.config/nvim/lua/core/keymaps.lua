vim.g.mapleader = " "

local map = vim.keymap.set
local opts = { noremap = true, silent = true }

-- Window navigation
map("n", "<C-h>", "<C-w>h", opts)
map("n", "<C-j>", "<C-w>j", opts)
map("n", "<C-k>", "<C-w>k", opts)
map("n", "<C-l>", "<C-w>l", opts)

-- File ops
map("n", "<leader>w", ":w<CR>", { desc = "Save file" })
map("n", "<leader>q", ":q<CR>", { desc = "Quit" })
map("n", "<leader>h", ":noh<CR>", { desc = "Clear search highlight" })

-- NvimTree (cmd lazy-loads the plugin)
map("n", "<leader>e", "<cmd>NvimTreeToggle<CR>", { desc = "Toggle NvimTree", silent = true })

-- Buffer tabs (bufferline)
map("n", "<S-l>", "<cmd>BufferLineCycleNext<CR>", { desc = "Next buffer", silent = true })
map("n", "<S-h>", "<cmd>BufferLineCyclePrev<CR>", { desc = "Prev buffer", silent = true })
map("n", "<leader>bd", function()
    local bufnr = vim.api.nvim_get_current_buf()
    vim.cmd("bprevious")
    vim.cmd("bdelete " .. bufnr)
end, { desc = "Delete buffer (keep window)", silent = true })
map("n", "<leader>bp", "<cmd>BufferLinePick<CR>", { desc = "Pick buffer", silent = true })

-- Telescope (cmd lazy-loads the plugin via :Telescope)
map("n", "<leader>ff", "<cmd>Telescope find_files<CR>", { desc = "Telescope find files" })
map("n", "<leader>fg", "<cmd>Telescope live_grep<CR>", { desc = "Telescope live grep" })
map("n", "<leader>fb", "<cmd>Telescope buffers<CR>", { desc = "Telescope buffers" })
map("n", "<leader>fh", "<cmd>Telescope help_tags<CR>", { desc = "Telescope help tags" })
map("n", "<leader>fs", "<cmd>Telescope grep_string<CR>", { desc = "Telescope grep string" })
map("n", "<leader>fo", "<cmd>Telescope oldfiles<CR>", { desc = "Telescope oldfiles" })

-- LSP status
map("n", "<leader>ls", function()
    print(vim.inspect(vim.lsp.get_clients({ bufnr = 0 })))
end, { desc = "LSP: show clients attached to current buffer" })

-- Per-buffer LSP keybindings (autocmd is global, fires when any LSP attaches).
vim.api.nvim_create_autocmd("LspAttach", {
    group = vim.api.nvim_create_augroup("UserLspConfig", { clear = true }),
    callback = function(ev)
        local bufopts = { buffer = ev.buf }
        map("n", "gD", vim.lsp.buf.declaration, bufopts)
        map("n", "gd", "<cmd>Telescope lsp_definitions<CR>", bufopts)
        map("n", "K", vim.lsp.buf.hover, bufopts)
        map("n", "gi", vim.lsp.buf.implementation, bufopts)
        map("n", "<C-k>", vim.lsp.buf.signature_help, bufopts)
        map("n", "<leader>rn", vim.lsp.buf.rename, bufopts)
        map({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, bufopts)
        map("n", "gr", vim.lsp.buf.references, bufopts)

        -- Inlay hints: enable if the client supports them, with a toggle.
        local client = vim.lsp.get_client_by_id(ev.data.client_id)
        if client and client.server_capabilities.inlayHintProvider and vim.lsp.inlay_hint then
            vim.lsp.inlay_hint.enable(true, { bufnr = ev.buf })
            map("n", "<leader>ih", function()
                vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = ev.buf }), { bufnr = ev.buf })
            end, vim.tbl_extend("force", bufopts, { desc = "Toggle inlay hints" }))
        end
    end,
})

-- TypeScript tools convenience commands (only meaningful in TS/JS buffers).
map("n", "<leader>to", "<cmd>TSToolsOrganizeImports<CR>", { desc = "TS: organize imports" })
map("n", "<leader>ta", "<cmd>TSToolsAddMissingImports<CR>", { desc = "TS: add missing imports" })
map("n", "<leader>tu", "<cmd>TSToolsRemoveUnusedImports<CR>", { desc = "TS: remove unused imports" })
map("n", "<leader>tf", "<cmd>TSToolsFixAll<CR>", { desc = "TS: fix all" })
map("n", "<leader>tr", "<cmd>TSToolsRenameFile<CR>", { desc = "TS: rename file" })
