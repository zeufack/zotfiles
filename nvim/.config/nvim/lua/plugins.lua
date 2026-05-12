local pckr = require("pckr")
local event = require("pckr.loader.event")
local cmd = require("pckr.loader.cmd")
local keys = require("pckr.loader.keys")

local function cfg(name)
    return function() require("plugin_configs." .. name) end
end

-- Custom pckr cond: load nvim-tree on VimEnter only if nvim was launched with a directory arg.
local function on_dir_arg()
    return function(load)
        vim.api.nvim_create_autocmd("VimEnter", {
            once = true,
            desc = "nvim-tree: load and open when nvim was launched with a directory",
            callback = function()
                local first = vim.fn.argv(0)
                if type(first) == "string" and first ~= "" and vim.fn.isdirectory(first) == 1 then
                    load()
                    require("nvim-tree.api").tree.open({ path = first, current_window = true })
                end
            end,
        })
    end
end

pckr.add({
    -- Theme: eager so colors apply before the first paint.
    {
        "folke/tokyonight.nvim",
        config = function() vim.cmd.colorscheme("tokyonight") end,
    },

    -- Treesitter (+ JSX/HTML auto-tags via ts-autotag)
    {
        "nvim-treesitter/nvim-treesitter",
        run = ":TSUpdate",
        cond = event("BufRead"),
        requires = { "windwp/nvim-ts-autotag" },
        config = cfg("treesitter"),
    },

    -- LSP — pulls mason + mason-lspconfig + cmp-nvim-lsp + SchemaStore via requires.
    {
        "neovim/nvim-lspconfig",
        cond = event("BufReadPre"),
        requires = {
            "williamboman/mason.nvim",
            "williamboman/mason-lspconfig.nvim",
            "hrsh7th/cmp-nvim-lsp",
            "b0o/SchemaStore.nvim",
        },
        config = cfg("lsp"),
    },

    -- TypeScript tooling — replaces ts_ls with a faster, richer implementation.
    -- Loads on TS/JS filetypes; lspconfig is already loaded by BufReadPre at that point.
    {
        "pmizio/typescript-tools.nvim",
        cond = event("FileType", { "typescript", "typescriptreact", "javascript", "javascriptreact" }),
        requires = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
        config = cfg("typescript_tools"),
    },

    -- Standalone Mason trigger so :Mason works before any buffer is read.
    { "williamboman/mason.nvim", cond = cmd("Mason") },

    -- Formatter
    {
        "stevearc/conform.nvim",
        cond = event("BufWritePre"),
        config = cfg("conform"),
    },

    -- Autocompletion — pulls all cmp sources + LuaSnip + autopairs via requires.
    -- Autopairs is required here so nvim-autopairs.completion.cmp is on rtp
    -- when cmp.lua wires up confirm_done.
    {
        "hrsh7th/nvim-cmp",
        cond = event("InsertEnter"),
        requires = {
            "hrsh7th/cmp-nvim-lsp",
            "hrsh7th/cmp-buffer",
            "hrsh7th/cmp-path",
            "hrsh7th/cmp-cmdline",
            {
                "L3MON4D3/LuaSnip",
                requires = { "rafamadriz/friendly-snippets" },
                config = function() end,
            },
            "saadparwaiz1/cmp_luasnip",
            { "windwp/nvim-autopairs", config = cfg("autopairs") },
        },
        config = cfg("cmp"),
    },

    -- Python: virtualenv picker. :VenvSelect activates an env for LSP + DAP.
    {
        "linux-cultist/venv-selector.nvim",
        cond = cmd("VenvSelect"),
        requires = {
            "neovim/nvim-lspconfig",
            "nvim-telescope/telescope.nvim",
            "mfussenegger/nvim-dap-python",
        },
        config = cfg("venv_selector"),
    },

    -- Debugging: nvim-dap + dap-ui + dap-python + dap-go.
    -- Run :MasonInstall debugpy delve once after first launch.
    {
        "mfussenegger/nvim-dap",
        cond = event("FileType", { "python", "go" }),
        requires = {
            { "rcarriga/nvim-dap-ui", requires = { "nvim-neotest/nvim-nio" } },
            "mfussenegger/nvim-dap-python",
            "leoluz/nvim-dap-go",
        },
        config = cfg("dap"),
    },

    -- Test runner: neotest with pytest + go adapters.
    {
        "nvim-neotest/neotest",
        cond = event("FileType", { "python", "go" }),
        requires = {
            "nvim-lua/plenary.nvim",
            "nvim-neotest/nvim-nio",
            "antoinemadec/FixCursorHold.nvim",
            "nvim-treesitter/nvim-treesitter",
            "nvim-neotest/neotest-python",
            "fredrikaverpil/neotest-golang",
        },
        config = cfg("neotest"),
    },

    -- Telescope — load on :Telescope (keymaps in core/keymaps.lua use <cmd>Telescope ...<CR>).
    {
        "nvim-telescope/telescope.nvim",
        cond = cmd("Telescope"),
        requires = {
            "nvim-lua/plenary.nvim",
            { "nvim-telescope/telescope-fzf-native.nvim", run = "make" },
            "nvim-telescope/telescope-file-browser.nvim",
        },
        config = cfg("telescope"),
    },

    -- Comment
    {
        "numToStr/Comment.nvim",
        cond = { keys("n", "gc"), keys("n", "gcc"), keys("v", "gc") },
        config = function() require("Comment").setup() end,
    },

    -- Colorizer
    {
        "norcalli/nvim-colorizer.lua",
        cond = event("BufRead"),
        config = function() require("colorizer").setup() end,
    },

    -- File Explorer
    {
        "nvim-tree/nvim-tree.lua",
        cond = { cmd("NvimTreeToggle"), on_dir_arg() },
        requires = { "nvim-tree/nvim-web-devicons" },
        config = cfg("nvim_tree"),
    },

    -- Git integration
    {
        "lewis6991/gitsigns.nvim",
        cond = event("BufReadPre"),
        config = function() require("gitsigns").setup() end,
    },

    -- Status line
    {
        "nvim-lualine/lualine.nvim",
        cond = event("VimEnter"),
        config = function() require("lualine").setup() end,
    },

    -- Buffer tabs
    {
        "akinsho/bufferline.nvim",
        cond = event("VimEnter"),
        requires = { "nvim-tree/nvim-web-devicons" },
        config = cfg("bufferline"),
    },

    -- Notifications / cmdline UI
    {
        "folke/noice.nvim",
        cond = event("VimEnter"),
        requires = { "MunifTanjim/nui.nvim", "rcarriga/nvim-notify" },
        config = cfg("noice"),
    },

    -- Keymap discovery popup (lazy.vim-style help)
    {
        "folke/which-key.nvim",
        cond = event("VimEnter"),
        config = cfg("which_key"),
    },
})
