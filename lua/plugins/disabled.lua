return {
    { "nvim-neo-tree/neo-tree.nvim", enabled = false },
    {
        "folke/snacks.nvim",
        opts = {
            explorer = { enabled = false },
        },
        keys = {
            -- Disable the default explorer keymaps
            { "<leader>e", false },
            { "<leader>E", false },
        },
    },
}
