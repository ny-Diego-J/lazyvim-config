return {
    {
        "eandrju/cellular-automaton.nvim",
        keys = {
            { "<leader>hr", "<cmd>CellularAutomaton make_it_rain<CR>", desc = "Make it rain!" },
            { "<leader>hg", "<cmd>CellularAutomaton game_of_life<CR>", desc = "Game of Life" },
        },
    },

    {
        "IogaMaster/neocord",
        event = "VeryLazy",
        opts = {
            logo = "auto",
            show_time = true,
            global_timer = true,
        },
    },

    {
        "wakatime/vim-wakatime",
        event = "LazyFile",
    },

    { "folke/tokyonight.nvim", priority = 1000 },

    {
        "folke/tokyonight.nvim",
        lazy = false,
        priority = 1000,
        opts = {
            style = "moon",
            transparent = vim.g.neovide_transparency ~= nil,
        },
    },
}
