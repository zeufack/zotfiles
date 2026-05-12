local servers = require("core.lsp_servers")
local capabilities = require("cmp_nvim_lsp").default_capabilities()

vim.lsp.config("*", { capabilities = capabilities })

vim.lsp.config("jsonls", {
    settings = {
        json = {
            schemas = require("schemastore").json.schemas(),
            validate = { enable = true },
        },
    },
})

vim.lsp.config("emmet_language_server", {
    filetypes = {
        "html", "css", "scss", "sass", "less",
        "javascriptreact", "typescriptreact", "vue", "svelte",
    },
})

-- Python: pyright owns types/hover, ruff owns lint + organize imports.
vim.lsp.config("pyright", {
    settings = {
        pyright = {
            -- Ruff handles import organization.
            disableOrganizeImports = true,
        },
        python = {
            analysis = {
                -- Ruff handles lint diagnostics; let pyright stick to types.
                ignore = { "*" },
            },
        },
    },
})

vim.lsp.config("ruff", {
    on_attach = function(client, _)
        -- Pyright owns hover so we don't get duplicate popups.
        client.server_capabilities.hoverProvider = false
    end,
})

vim.lsp.config("gopls", {
    settings = {
        gopls = {
            gofumpt = true,
            staticcheck = true,
            usePlaceholders = true,
            completeUnimported = true,
            analyses = {
                unusedparams = true,
                unusedwrite = true,
                nilness = true,
                shadow = true,
                useany = true,
            },
            hints = {
                assignVariableTypes = true,
                compositeLiteralFields = true,
                compositeLiteralTypes = true,
                constantValues = true,
                functionTypeParameters = true,
                parameterNames = true,
                rangeVariableTypes = true,
            },
            semanticTokens = true,
        },
    },
})

require("mason").setup()
require("mason-lspconfig").setup({
    ensure_installed = servers,
    automatic_installation = true,
    -- ts_ls binary is installed via Mason but typescript-tools.nvim owns the
    -- client; exclude it from auto-enable so we don't get two TS servers.
    automatic_enable = { exclude = { "ts_ls" } },
})
