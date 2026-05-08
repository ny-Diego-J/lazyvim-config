-- running live websites
return {
    "selimacerbas/live-server.nvim",
    cmd = { "LiveServerStart", "LiveServerStop" },
    keys = {
        { "<leader>ls", "<cmd>LiveServerStart<cr>", desc = "Start Live Server" },
        { "<leader>lS", "<cmd>LiveServerStop<cr>", desc = "Stop Live Server" },
    },
    config = function()
        require("live_server").setup({
            port = 8080,
            open_in_browser = true,
        })
    end,
}
