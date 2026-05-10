-- themes to test out
return {
    {
        "folke/tokyonight.nvim",
        lazy = true,
        opts = { style = "moon" },
    },
    {
        "LazyVim/LazyVim",
        opts = {
            colorscheme = "tokyonight",
        },
    },
}
