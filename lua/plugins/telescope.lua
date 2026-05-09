return {
    "nvim-telescope/telescope.nvim",
    branch = "0.1.x",
    dependencies = {
        "nvim-lua/plenary.nvim",
        {
            "nvim-telescope/telescope-fzf-native.nvim",
            build = vim.fn.has("win32") == 1
                    and "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release"
                or "make",
        },
    },
    keys = {
        { "<leader>jt", "<cmd>Telescope find_files<cr>", desc = "Find Files" },
        { "<C-p>", "<cmd>Telescope git_files<cr>", desc = "Git Files" },
        {
            "<leader>js",
            function()
                require("telescope.builtin").grep_string({ search = vim.fn.expand("<cword>") })
            end,
            desc = "Grep Word",
        },
        { "<leader>vh", "<cmd>Telescope help_tags<cr>", desc = "Help Tags" },
    },
    opts = {
        defaults = {
            path_display = { "truncate" },
        },
    },
}
