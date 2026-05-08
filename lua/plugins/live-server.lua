return {
    "selimacerbas/live-server.nvim",
    -- Load the plugin only when you run these commands or press the keys
    cmd = { "LiveServerStart", "LiveServerStop" },
    keys = {
        { "<leader>ls", "<cmd>LiveServerStart<cr>", desc = "Start Live Server" },
        { "<leader>lS", "<cmd>LiveServerStop<cr>", desc = "Stop Live Server" },
    },
    config = function()
        require("live_server").setup({
            -- You can customize your settings here
            port = 8080, -- The port the server will run on
            open_in_browser = true, -- Automatically opens your default browser
        })
    end,
}
