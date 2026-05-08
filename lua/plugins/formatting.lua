return {
    {
        "stevearc/conform.nvim",
        opts = {
            formatters_by_ft = {
                java = { "lsp" },
            },
            format_on_save = {
                -- Wir geben Java 3000ms (3 Sekunden) Zeit zum Formatieren!
                timeout_ms = 3000,
                lsp_format = "fallback",
            },
        },
    },
}
