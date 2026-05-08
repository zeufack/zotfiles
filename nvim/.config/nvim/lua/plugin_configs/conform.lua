require("conform").setup({
    formatters_by_ft = {
        lua = { "stylua" },
        python = { "isort", "black" },
        rust = { "rustfmt" },
        go = { "goimports" },
        zig = { "zigfmt" },
        javascript = { "prettierd", "prettier" },
        typescript = { "prettierd", "prettier" },
    },
    format_on_save = {
        timeout_ms = 1000,
        lsp_format = "fallback",
    },
})
