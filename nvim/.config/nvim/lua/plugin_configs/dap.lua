local dap = require("dap")
local dapui = require("dapui")

dapui.setup()

-- Use the debugpy installed via :MasonInstall debugpy.
local mason_debugpy = vim.fn.stdpath("data") .. "/mason/packages/debugpy/venv/bin/python"
require("dap-python").setup(vim.fn.executable(mason_debugpy) == 1 and mason_debugpy or "python3")

-- Go: delve adapter via dap-go. Run :MasonInstall delve once.
require("dap-go").setup()

-- Auto-open/close dap-ui around debug sessions.
dap.listeners.after.event_initialized["dapui_config"] = function() dapui.open() end
dap.listeners.before.event_terminated["dapui_config"] = function() dapui.close() end
dap.listeners.before.event_exited["dapui_config"] = function() dapui.close() end

local map = vim.keymap.set
map("n", "<leader>db", function() dap.toggle_breakpoint() end, { desc = "DAP: toggle breakpoint" })
map("n", "<leader>dB", function()
    dap.set_breakpoint(vim.fn.input("Condition: "))
end, { desc = "DAP: conditional breakpoint" })
map("n", "<leader>dc", function() dap.continue() end, { desc = "DAP: continue / start" })
map("n", "<leader>di", function() dap.step_into() end, { desc = "DAP: step into" })
map("n", "<leader>do", function() dap.step_over() end, { desc = "DAP: step over" })
map("n", "<leader>dO", function() dap.step_out() end, { desc = "DAP: step out" })
map("n", "<leader>dr", function() dap.repl.toggle() end, { desc = "DAP: toggle REPL" })
map("n", "<leader>dl", function() dap.run_last() end, { desc = "DAP: run last" })
map("n", "<leader>du", function() dapui.toggle() end, { desc = "DAP: toggle UI" })
map("n", "<leader>dx", function() dap.terminate() end, { desc = "DAP: terminate" })

-- Python-specific (dap-python).
map("n", "<leader>dn", function() require("dap-python").test_method() end, { desc = "DAP-py: test method" })
map("n", "<leader>df", function() require("dap-python").test_class() end, { desc = "DAP-py: test class" })
map("v", "<leader>ds", function() require("dap-python").debug_selection() end, { desc = "DAP-py: debug selection" })
