local servers = require("core.lsp_servers")
local lspconfig = require("lspconfig")
local capabilities = require("cmp_nvim_lsp").default_capabilities()

require("mason").setup()
require("mason-lspconfig").setup({
    ensure_installed = servers,
    automatic_installation = true,
    handlers = {
        -- Default handler: capabilities only.
        function(server_name)
            lspconfig[server_name].setup({
                capabilities = capabilities,
            })
        end,

        -- ts_ls: installed via Mason for the binary, but typescript-tools.nvim
        -- handles attachment/configuration. Skip the lspconfig setup here.
        ["ts_ls"] = function() end,

        -- jsonls: pull schemas from SchemaStore for package.json, tsconfig, etc.
        ["jsonls"] = function()
            lspconfig.jsonls.setup({
                capabilities = capabilities,
                settings = {
                    json = {
                        schemas = require("schemastore").json.schemas(),
                        validate = { enable = true },
                    },
                },
            })
        end,

        -- emmet_language_server: enable for the relevant filetypes.
        ["emmet_language_server"] = function()
            lspconfig.emmet_language_server.setup({
                capabilities = capabilities,
                filetypes = {
                    "html", "css", "scss", "sass", "less",
                    "javascriptreact", "typescriptreact", "vue", "svelte",
                },
            })
        end,
    },
})
