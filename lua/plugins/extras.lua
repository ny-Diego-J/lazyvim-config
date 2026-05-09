-- misc plugins
return {
    {
        "folke/which-key.nvim",
        opts = function()
            local wk = require("which-key")
            wk.add({
                { "<leader>h", group = "Fun & History", icon = "" },
            })
        end,
    },

    -- 1. Cellular Automaton. Funny idle animations
    {
        "eandrju/cellular-automaton.nvim",
        keys = {
            { "<leader>hr", "<cmd>CellularAutomaton make_it_rain<CR>", desc = "Make it rain!" },
            { "<leader>hg", "<cmd>CellularAutomaton game_of_life<CR>", desc = "Game of Life" },
        },
    },

    -- 2. Neocord (Discord Rich Presence)
    {
        "IogaMaster/neocord",
        event = "VeryLazy",
        opts = {
            logo = "auto",
            show_time = true,
            global_timer = true,
        },
    },

    -- 3. Undotree peak
    -- {
    --     "mbbill/undotree",
    --
    --     init = function()
    --         if vim.fn.has("win32") == 1 then
    --             vim.g.undotree_DiffCommand = "C:/Program Files/Git/usr/bin/diff.exe"
    --         end
    --     end,
    -- },

    -- 4. WakaTime (Statistiken sammeln)
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
