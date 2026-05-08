require("nvim-treesitter.configs").setup({
    ensure_installed = {
        "go", "lua", "vim", "python", "zig",
        -- TS / React / Next.js stack
        "javascript", "typescript", "tsx", "jsdoc",
        "html", "css", "scss", "json", "json5", "markdown",
    },
    sync_install = false,
    auto_install = true,
    ignore_install = {},
    highlight = { enable = true },
    indent = { enable = true },
})

require("nvim-ts-autotag").setup({
    opts = {
        enable_close = true,
        enable_rename = true,
        enable_close_on_slash = true,
    },
})
