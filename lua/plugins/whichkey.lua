return {
    "folke/which-key.nvim",
    event = "VeryLazy",
    config = function()
        local wk = require("which-key")
        wk.setup({})
        wk.add({
            { "<leader>h", group = "Fun & History", icon = "" },
            { "<leader>j", group = "find and seach", icon = "" },
        })
    end,
}
