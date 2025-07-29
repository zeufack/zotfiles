local pckr = require("pckr")

pckr.add({
    -- Theme
    "folke/tokyonight.nvim", -- Treesitter
    {
        "nvim-treesitter/nvim-treesitter",
        run = ":TSUpdate",
        lazy = true,
        event = "BufRead"
    }, -- LSP
    { "neovim/nvim-lspconfig",             lazy = true,       event = "BufRead" },
    { "williamboman/mason.nvim",           lazy = true,       cmd = "Mason" },
    { "williamboman/mason-lspconfig.nvim", lazy = true,       after = "mason.nvim" },

    -- Formatter
    { "stevearc/conform.nvim",             lazy = true,       event = "BufWritePre" },

    -- Autocompletion
    { "hrsh7th/nvim-cmp",                  lazy = true,       event = "InsertEnter" },
    { "hrsh7th/cmp-nvim-lsp",              after = "nvim-cmp" },
    { "hrsh7th/cmp-buffer",                after = "nvim-cmp" },
    { "hrsh7th/cmp-path",                  after = "nvim-cmp" },
    { "hrsh7th/cmp-cmdline",               after = "nvim-cmp" },
    { "L3MON4D3/LuaSnip",                  after = "nvim-cmp" },
    { "saadparwaiz1/cmp_luasnip",          after = "nvim-cmp" }, -- Auto-close
    {
        "windwp/nvim-autopairs",
        event = "InsertEnter",
        dependencies = { "nvim-treesitter/nvim-treesitter" }           -- Ensure treesitter is available
    },                                                                 -- Go-specific plugins
    { "fatih/vim-go",                  lazy = true,       ft = "go" }, -- Fuzzy finder
        { "nvim-lua/plenary.nvim",         lazy = true },
    { "nvim-telescope/telescope.nvim", cmd = "Telescope", after = "plenary.nvim" },
    {
        "nvim-telescope/telescope-fzf-native.nvim",
        run = "make",
        after = "telescope.nvim"
    }, { "nvim-telescope/telescope-file-browser.nvim", after = "telescope.nvim" },

    -- Comment
    { "numToStr/Comment.nvim",                      lazy = true,             event = "BufRead" }, -- Colorizer
    { "norcalli/nvim-colorizer.lua",                lazy = true,             event = "BufRead" },

    -- File Explorer
    { "nvim-tree/nvim-web-devicons",                lazy = true }, {
    "nvim-tree/nvim-tree.lua",
    cmd = "NvimTreeToggle",
    after = "nvim-web-devicons"
},                                                                   -- Git integration
    { "lewis6991/gitsigns.nvim",   lazy = true, event = "BufRead" }, -- Tabline
    { "romgrk/barbar.nvim",        lazy = true, event = "VimEnter" }, -- Tabline, -- Status line
    { "nvim-lualine/lualine.nvim", lazy = true, event = "BufRead" },

    -- Notifications
    {
        "folke/noice.nvim",
        lazy = true,
        event = "VimEnter",
        requires = { "MunifTanjim/nui.nvim", "rcarriga/nvim-notify" }
    }
})