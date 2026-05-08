return {
    {
        "stevearc/conform.nvim",
        opts = {
            formatters_by_ft = {
                java = { "lsp" },
            },
            format_on_save = {
                timeout_ms = 3000,
                lsp_format = "fallback",
            },
        },
    },
}
