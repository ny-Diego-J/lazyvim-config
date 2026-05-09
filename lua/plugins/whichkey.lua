return {
    "folke/which-key.nvim",
    opts = function()
        local wk = require("which-key")
        wk.add({
            { "<leader>h", group = "Fun & History", icon = "" },
            { "<leader>j", group = "find and seach", icon = "" },
        })
    end,
}
