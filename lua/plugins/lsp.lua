return {
    -- LSP Configuration
    {
        "neovim/nvim-lspconfig",
        dependencies = {
            "williamboman/mason.nvim",
            "williamboman/mason-lspconfig.nvim",
            "saghen/blink.cmp",
        },
        config = function()
            require("mason").setup()
            require("mason-lspconfig").setup({
                ensure_installed = { "lua_ls", "clangd" },
            })

            local capabilities = require("blink.cmp").get_lsp_capabilities()

            if vim.lsp.config then
                -- Neovim 0.11+ native way
                vim.lsp.config("lua_ls", {
                    capabilities = capabilities,
                })
                vim.lsp.enable("lua_ls")

                vim.lsp.config("clangd", {
                    capabilities = capabilities,
                })
                vim.lsp.enable("clangd")
            else
                -- Fallback for Neovim 0.10 and older
                local lspconfig = require("lspconfig")
                lspconfig.lua_ls.setup({
                    capabilities = capabilities,
                })
                lspconfig.clangd.setup({
                    capabilities = capabilities,
                })
            end
        end,
    },

    -- Autocompletion Engine
    {
        "saghen/blink.cmp",
        version = "*",
        opts = {
            keymap = { preset = "default" },
            sources = {
                default = { "lsp", "path", "snippets", "buffer" },
            },
        },
    },
}
