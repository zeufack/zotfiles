local neotest = require("neotest")

neotest.setup({
    adapters = {
        require("neotest-python")({
            -- Use whichever python is on PATH after venv activation.
            runner = "pytest",
            dap = { justMyCode = false },
        }),
        require("neotest-golang")({
            go_test_args = { "-v", "-race", "-count=1" },
            dap_go_enabled = true,
        }),
    },
    output = { open_on_run = true },
    quickfix = { enabled = false },
})

local map = vim.keymap.set
map("n", "<leader>nt", function() neotest.run.run() end, { desc = "Test: nearest" })
map("n", "<leader>nf", function() neotest.run.run(vim.fn.expand("%")) end, { desc = "Test: file" })
map("n", "<leader>na", function() neotest.run.run(vim.uv.cwd()) end, { desc = "Test: all" })
map("n", "<leader>nd", function() neotest.run.run({ strategy = "dap" }) end, { desc = "Test: debug nearest" })
map("n", "<leader>ns", function() neotest.summary.toggle() end, { desc = "Test: toggle summary" })
map("n", "<leader>no", function() neotest.output.open({ enter = true }) end, { desc = "Test: show output" })
map("n", "<leader>np", function() neotest.output_panel.toggle() end, { desc = "Test: toggle output panel" })
map("n", "<leader>nx", function() neotest.run.stop() end, { desc = "Test: stop" })
