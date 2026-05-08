require("snacks").setup({
    explorer = {
        watch = { enabled = false },
    },
})
return {
    {
        "folke/snacks.nvim",
        opts = {
            picker = {
                sources = {
                    explorer = {
                        -- Zeigt versteckte Dateien (Dotfiles) standardmäßig an
                        hidden = true,
                        ignored = false,
                    },
                },
            },
        },
    },
}
