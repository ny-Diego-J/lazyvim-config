require("snacks").setup({
    explorer = {
        watch = { enabled = false }, -- deaktiviert den fehlerhaften Filewatcher
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
                        -- Falls du auch Dateien sehen willst, die in der .gitignore stehen:
                        -- ignored = true,
                    },
                },
            },
        },
    },
}
