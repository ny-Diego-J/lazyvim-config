return {
    "akinsho/git-conflict.nvim",
    version = "*",
    lazy = false,
    config = function()
        require("git-conflict").setup({
            default_mappings = false,
            default_commands = true,
            disable_diagnostics = false,
            list_opener = "copen",
            highlights = {
                incoming = "DiffAdd",
                current = "DiffText",
            },
        })

        local keymap = vim.keymap.set

        keymap("n", "[x", "<Plug>(git-conflict-prev-conflict)", { desc = "Vorheriger Git-Konflikt" })
        keymap("n", "]x", "<Plug>(git-conflict-next-conflict)", { desc = "Nächster Git-Konflikt" })

        keymap("n", "+o", "<Plug>(git-conflict-ours)", { desc = "Ours wählen" })
        keymap("n", "+t", "<Plug>(git-conflict-theirs)", { desc = "Theirs wählen" })
        keymap("n", "+b", "<Plug>(git-conflict-both)", { desc = "Both wählen" })
        keymap("n", "+0", "<Plug>(git-conflict-none)", { desc = "Keine Änderungen wählen" })
    end,
}
