return {
    "gopls",
    "lua_ls",
    "pyright",
    "ruff",
    -- TS/JS/React/Next stack
    "ts_ls", -- installed via mason for typescript-tools.nvim; setup is no-op'd in lsp.lua
    "eslint",
    "tailwindcss",
    "jsonls",
    "html",
    "cssls",
    "emmet_language_server",
    -- DevOps: Docker + Kubernetes
    "dockerls", -- Dockerfiles
    "docker_compose_language_service", -- compose.yaml / docker-compose.yml
    "yamlls", -- YAML + Kubernetes manifests (schemas wired in lsp.lua)
}
