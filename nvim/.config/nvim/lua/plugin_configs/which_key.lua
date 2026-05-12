local wk = require("which-key")

wk.setup({
    preset = "modern",
    delay = 300,
})

wk.add({
    { "<leader>f", group = "Find" },
    { "<leader>b", group = "Buffer" },
    { "<leader>t", group = "TypeScript" },
    { "<leader>c", group = "Code" },
    { "<leader>r", group = "Rename" },
    { "<leader>i", group = "Inlay" },
    { "<leader>l", group = "LSP" },
    { "<leader>d", group = "Debug" },
    { "<leader>n", group = "Test" },
    { "<leader>v", group = "Venv" },
})

vim.keymap.set("n", "<leader>?", function() wk.show({ global = true }) end,
    { desc = "Show all keymaps" })
