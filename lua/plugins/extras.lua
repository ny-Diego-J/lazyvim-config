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
}
