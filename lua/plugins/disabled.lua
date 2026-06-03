return {
    { "nvim-neo-tree/neo-tree.nvim", enabled = false },
    {
        "folke/snacks.nvim",
        opts = {
            explorer = { enabled = false },
        },
        keys = {
            { "<leader>e", false },
            { "<leader>E", false },
        },
    },
    { "akinsho/bufferline.nvim", enabled = false },
}
