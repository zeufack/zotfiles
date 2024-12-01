local pckr = require("pckr")

pckr.add({
	-- Theme
	"folke/tokyonight.nvim",

	-- Treesitter
	{ "nvim-treesitter/nvim-treesitter", run = ":TSUpdate" },

	-- LSP
	"neovim/nvim-lspconfig",
	"williamboman/mason.nvim",
	"williamboman/mason-lspconfig.nvim",

	-- Formatter
	"stevearc/conform.nvim",

	-- Autocompletion
	"hrsh7th/cmp-nvim-lsp",
	"hrsh7th/cmp-buffer",
	"hrsh7th/cmp-path",
	"hrsh7th/cmp-cmdline",
	"hrsh7th/nvim-cmp",
	"L3MON4D3/LuaSnip",
	"saadparwaiz1/cmp_luasnip",

	-- Auto-cole
	"windwp/nvim-autopairs",

	-- Go-specific plugins
	"fatih/vim-go",

	-- Fuzzy finder
	"nvim-lua/plenary.nvim",
	"nvim-telescope/telescope.nvim",
	{ "nvim-telescope/telescope-fzf-native.nvim", run = "make" },

	-- File Explorer
	"nvim-tree/nvim-web-devicons",
	"nvim-tree/nvim-tree.lua",

	-- Git intergration
	"lewis6991/gitsigns.nvim",
	-- Tabline
	"romgrk/barbar.nvim",

	-- Tabline icons sets
	-- "nvim-tree/nvim-web-devicons",
	-- Status line
	"nvim-lualine/lualine.nvim",
})
