return {
    "nvim-telescope/telescope.nvim",
    branch = "0.1.x",
    cmd = "Telescope",
    dependencies = {
        "nvim-lua/plenary.nvim",
        {
            "nvim-telescope/telescope-fzf-native.nvim",
            build = vim.fn.has("win32") == 1
                    and "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release"
                or "make",
        },
    },
    opts = {
        defaults = {
            path_display = { "truncate" },
        },
    },
}
