-- Theme
vim.cmd([[colorscheme tokyonight]])

-- Treesitter
require("nvim-treesitter.configs").setup({
    -- A list of parser names, or "all" (the listed parsers MUST always be installed)
    ensure_installed = {
        "go", "lua", "vim", "typescript", "javascript", "python", "zig"
    },
    -- Install parsers synchronously (only applied to `ensure_installed`)
    sync_install = false,

    -- Automatically install missing parsers when entering buffer
    -- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
    auto_install = true,

    -- List of parsers to ignore installing (or "all")
    ignore_install = {},
    highlight = { enable = true }
})

local servers = require("core.lsp_servers")

-- Mason setup
require("mason").setup()
require("mason-lspconfig").setup({
    ensure_installed = servers,
    automatic_installation = true,
    handlers = {
        function(server_name)
            lspconfig[server_name].setup({
                capabilities = capabilities,
                settings = lsp_configs[server_name] or {},
            })
        end,
    }
})

-- Global LSP keybindings
vim.api.nvim_create_autocmd("LspAttach", {
    group = vim.api.nvim_create_augroup("UserLspConfig", { clear = true }),
    callback = function(ev)
        local opts = { buffer = ev.buf }
        vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
        vim.keymap.set("n", "gd", require('telescope.builtin').lsp_definitions, opts)
        vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
        vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
        vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, opts)
        vim.keymap.set("n", "<space>rn", vim.lsp.buf.rename, opts)
        vim.keymap.set({ "n", "v" }, "<space>ca", vim.lsp.buf.code_action, opts)
        vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
    end
})

-- Formatt
local conform = require("conform")
conform.setup({
    formatters_by_ft = {
        lua = { "stylua" },
        python = { "isort", "black" },
        rust = { "rustfmt" },
        go = { "goimports" },
        zig = { "zigfmt" },
        javascript = { "prettierd", "prettier" },
        typescript = { "prettierd", "prettier" }
    },
    format_on_save = {
        timeout_ms = 1000,
        lsp_format = "fallback"
    }
})

-- Autocompletion setup
local cmp = require("cmp")
local luasnip = require("luasnip")

cmp.setup({
    snippet = { expand = function(args) luasnip.lsp_expand(args.body) end },
    mapping = cmp.mapping.preset.insert({
        ["<C-d>"] = cmp.mapping.scroll_docs(-4),
        ["<C-f>"] = cmp.mapping.scroll_docs(4),
        ["<C-Space>"] = cmp.mapping.complete(),
        ["<CR>"] = cmp.mapping.confirm({
            behavior = cmp.ConfirmBehavior.Replace,
            select = true
        }),
        ["<Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_next_item()
            elseif luasnip.expand_or_jumpable() then
                luasnip.expand_or_jump()
            else
                fallback()
            end
        end, { "i", "s" }),
        ["<S-Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then
                luasnip.jump(-1)
            else
                fallback()
            end
        end, { "i", "s" })
    }),
    sources = {
        { name = "nvim_lsp" }, { name = "luasnip" }, { name = "buffer" },
        { name = "path" }
    }
})

-- Auto-close parentheses setup
require("nvim-autopairs").setup({
    check_ts = true,
    ts_config = {
        lua = { "string" },
        javascript = { "template_string" },
        java = false
    },
    disable_filetype = { "TelescopePrompt", "vim" }
})

-- Make autopairs and completion work together
local cmp_autopairs = require("nvim-autopairs.completion.cmp")
cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())

-- Telescope
local telescope = require("telescope")
telescope.setup({
    defaults = {
        mappings = {
            i = {
                ["<C-j>"] = "move_selection_next",
                ["<C-k>"] = "move_selection_previous"
            }
        }
    },
    extensions = {
        fzf = {
            fuzzy = true,
            override_generic_sorter = true,
            override_file_sorter = true,
            case_mode = "smart_case"
        },
        lsp = {
            jump_if_one_result = true,
        }
    }
})

-- Load the fzf extensions
telescope.load_extension("fzf")

-- Telescope keymaps
local builtin = require("telescope.builtin")
vim.keymap.set("n", "<leader>ff", builtin.find_files,
    { desc = "Telescope find files" })
vim.keymap.set("n", "<leader>fg", builtin.live_grep,
    { desc = "Telescope live grep" })
vim.keymap.set("n", "<leader>fb", builtin.buffers, { desc = "Telescope buffers" })
vim.keymap.set("n", "<leader>fh", builtin.help_tags,
    { desc = "Telescope help tags" })
vim.keymap.set("n", "<leader>fs", builtin.grep_string, {})
vim.keymap.set("n", "<leader>fo", builtin.oldfiles, {})

-- nvim-treesitter
local nvimtree = require("nvim-tree")
nvimtree.setup({})


-- Gitsigns
require("gitsigns").setup()

-- Lualine
require("lualine").setup()

-- Configure Noice
require("noice").setup({
    lsp = {
        override = {
            ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
            ["vim.lsp.util.stylize_markdown"] = true,
            ["cmp.entry.get_documentation"] = true
        }
    },
    presets = {
        bottom_search = true,
        command_palette = false,
        long_message_to_split = true,
        inc_rename = false,
        lsp_doc_border = false
    }
})

-- Load plugin configurations
require("plugin_configs.telescope_file_browser")
require("plugin_configs.comment")
require("plugin_configs.colorizer")