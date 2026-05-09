return {
    "nvim-telescope/telescope.nvim",
    branch = "0.1.x", -- Stabiler als ein alter fixer Tag
    dependencies = {
        "nvim-lua/plenary.nvim",
        {
            "nvim-telescope/telescope-fzf-native.nvim",
            -- Nutzt cmake unter Windows und make unter Arch Linux
            build = vim.fn.has("win32") == 1
                    and "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release"
                or "make",
        },
    },
    config = function()
        local telescope = require("telescope")

        telescope.setup({
            defaults = {
                -- Hier kannst du Standard-Optionen setzen
            },
        })

        -- Sicherere Treesitter-Highlighter Logik
        local preview_utils = require("telescope.previewers.utils")
        preview_utils.ts_highlighter = function(bufnr, ft)
            -- Prüfen, ob treesitter für diese Sprache verfügbar ist
            local ok, parser = pcall(vim.treesitter.get_parser, bufnr, ft)
            if not ok or not parser then
                return false
            end
            return pcall(vim.treesitter.start, bufnr, ft)
        end

        -- Keymaps
        local builtin = require("telescope.builtin")
        local map = vim.keymap.set

        map("n", "<leader>jj", builtin.find_files, { desc = "Find Files" })
        map("n", "<C-p>", builtin.git_files, { desc = "Git Files" })

        map("n", "<leader>js", function()
            local word = vim.fn.expand("<cword>")
            builtin.grep_string({ search = word })
        end, { desc = "Grep Word" })

        map("n", "<leader>pWs", function()
            local word = vim.fn.expand("<cWORD>")
            builtin.grep_string({ search = word })
        end, { desc = "Grep WORD" })

        map("n", "<leader>ps", function()
            builtin.grep_string({ search = vim.fn.input("Grep > ") })
        end, { desc = "Grep Input" })

        map("n", "<leader>vh", builtin.help_tags, { desc = "Help Tags" })
    end,
}
