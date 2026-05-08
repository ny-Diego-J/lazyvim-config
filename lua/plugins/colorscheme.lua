-- themes to test out
return {
    {
        "metalelf0/black-metal-theme-neovim",
    },
    {
        "rebelot/kanagawa.nvim",
    },
    { "ellisonleao/gruvbox.nvim" },
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
