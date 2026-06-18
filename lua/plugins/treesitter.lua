return {
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        config = function()
            require("nvim-treesitter").setup({
                ensure_installed = {
                    "lua", "vim", "vimdoc", "query", "java", "c", "cpp", "markdown", "markdown_inline"
                },
                highlight = {
                    enable = true,
                },
            })
        end,
    },
}
