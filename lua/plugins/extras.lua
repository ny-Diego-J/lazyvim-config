return {
    -- 0. Dem Menü einen coolen Namen geben (für das Which-Key Popup)
    {
        "folke/which-key.nvim",
        opts = function()
            local wk = require("which-key")
            wk.add({
                { "<leader>h", group = "Fun & History", icon = "" }, -- So heißt dein Menü jetzt
            })
        end,
    },

    -- 1. Cellular Automaton (Code schmelzen lassen)
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
            logo = "auto", -- Nimmt automatisch das Neovim-Logo
            show_time = true, -- Zeigt an, wie lange du schon codest
            global_timer = true,
        },
    },

    -- 3. Undotree (Die Zeitmaschine)
    {
        "mbbill/undotree",
        keys = {
            { "<leader>hu", "<cmd>UndotreeToggle<CR>", desc = "Undo Tree öffnen" },
            { "<leader>hf", "<cmd>UndotreeFocus<CR>", desc = "Undo Tree Fokussieren" },
        },
        init = function()
            -- Windows-Fix: Wir klauen uns das 'diff' Tool einfach aus deinem Git-Ordner
            if vim.fn.has("win32") == 1 then
                vim.g.undotree_DiffCommand = "C:/Program Files/Git/usr/bin/diff.exe"
            end
        end,
    },

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
            style = "moon", -- Hier sagen wir ihm, dass er IMMER Moon nehmen soll
            transparent = vim.g.neovide_transparency ~= nil, -- Macht den Hintergrund transparent für Neovide (falls du das nutzt)
        },
    },
}
