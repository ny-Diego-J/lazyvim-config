return {
    "3rd/image.nvim",
    opts = {
        backend = "kitty",
        integrations = {
            telescope = {
                enabled = true,
            },
        },
        max_height_window_percentage = 50,
        window_overlap_clear_ft_ignore = { "cmp_menu", "cmp_docs", "" },
    },
}
