return {
    "stevearc/conform.nvim",
    opts = function(_, opts)
        opts.formatters = opts.formatters or {}

        opts.formatters.prettier = {
            args = function(self, ctx)
                local ft = vim.bo[ctx.buf].filetype
                local width = (ft == "html" or ft == "css") and "2" or "4"

                return { "--stdin-filepath", "$FILENAME", "--tab-width", width }
            end,
        }
    end,
}
