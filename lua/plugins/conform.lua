return {
    "stevearc/conform.nvim",
    opts = {
        formatters_by_ft = {
            c = { "clang-format" },
            cpp = { "clang-format" },
            lua = { "stylua" },
            go = { "gofmt" },
            javascript = { "prettier" },
            typescript = { "prettier" },
            typescriptreact = { "prettier" },
            elixir = { "mix" },
            bash = { "shfmt" },
        },
        formatters = {
            ["clang-format"] = {
                prepend_args = { "-style=file", "-fallback-style=LLVM" },
            },
        },
    },
    keys = {
        {
            "<leader>jf",
            function()
                require("conform").format({ bufnr = 0 })
            end,
            desc = "Format buffer",
        },
    },
}
