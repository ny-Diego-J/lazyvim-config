-- Keymaps are automatically loaded on the VeryLazy event
-- Add any additional keymaps here
local map = vim.keymap.set
map("n", "<leader>e", ":Ex<CR>", { desc = "Open netrw explorer" })
map("n", "<leader>E", ":Sex<CR>", { desc = "Open netrw explorer" })

map("n", "<leader>jj", ":Telescope find_files<cr>", { desc = "Find Files" })
map("n", "<C-p>", ":Telescope git_files<cr>", { desc = "Git Files" })
map("n", "<leader>js", function()
    require("telescope.builtin").grep_string({ search = vim.fn.expand("<cword>") })
end, { desc = "Grep Word" })

map("n", "<F11>", function()
    vim.g.neovide_fullscreen = not vim.g.neovide_fullscreen
end, { desc = "Toggle Fullscreen" })

local harpoon = require("harpoon")
local harpoon_extensions = require("harpoon.extensions")

harpoon.setup({})
harpoon:extend(harpoon_extensions.builtins.highlight_current_file())

map("n", "<leader>a", function()
    harpoon:list():add()
end)
map("n", "<C-e>", function()
    harpoon.ui:toggle_quick_menu(harpoon:list())
end)

map("n", "<C-a>", function()
    harpoon:list():select(1)
end)
map("n", "<C-s>", function()
    harpoon:list():select(2)
end)
map("n", "<C-d>", function()
    harpoon:list():select(3)
end)
map("n", "<C-f>", function()
    harpoon:list():select(4)
end)

-- Toggle previous & next buffers stored within Harpoon list
map("n", "<C-S-P>", function()
    harpoon:list():prev()
end)
map("n", "<C-S-N>", function()
    harpoon:list():next()
end)

require("rose-pine").setup({
    variant = "auto", -- auto, main, moon, or dawn
    dark_variant = "main", -- main, moon, or dawn
    dim_inactive_windows = false,
    extend_background_behind_borders = true,

    enable = {
        terminal = true,
        legacy_highlights = true, -- Improve compatibility for previous versions of Neovim
        migrations = true, -- Handle deprecated options automatically
    },

    styles = {
        bold = true,
        italic = true,
        transparency = true,
    },

    groups = {
        border = "muted",
        link = "iris",
        panel = "surface",

        error = "love",
        hint = "iris",
        info = "foam",
        note = "pine",
        todo = "rose",
        warn = "gold",

        git_add = "foam",
        git_change = "rose",
        git_delete = "love",
        git_dirty = "rose",
        git_ignore = "muted",
        git_merge = "iris",
        git_rename = "pine",
        git_stage = "iris",
        git_text = "rose",
        git_untracked = "subtle",

        h1 = "iris",
        h2 = "foam",
        h3 = "rose",
        h4 = "gold",
        h5 = "pine",
        h6 = "foam",
    },

    palette = {
        -- Override the builtin palette per variant
        -- moon = {
        --     base = '#18191a',
        --     overlay = '#363738',
        -- },
    },

    -- NOTE: Highlight groups are extended (merged) by default. Disable this
    -- per group via `inherit = false`
    highlight_groups = {
        -- Comment = { fg = "foam" },
        -- StatusLine = { fg = "love", bg = "love", blend = 15 },
        -- VertSplit = { fg = "muted", bg = "muted" },
        -- Visual = { fg = "base", bg = "text", inherit = false },
    },

    before_highlight = function(group, highlight, palette)
        -- Disable all undercurls
        -- if highlight.undercurl then
        --     highlight.undercurl = false
        -- end
        --
        -- Change palette colour
        -- if highlight.fg == palette.pine then
        --     highlight.fg = palette.foam
        -- end
    end,
})

vim.cmd("colorscheme rose-pine")
-- vim.cmd("colorscheme rose-pine-main")
-- vim.cmd("colorscheme rose-pine-moon")
-- vim.cmd("colorscheme rose-pine-dawn")

-- Öffnet den tmux-sessionizer direkt aus Neovim heraus
vim.keymap.set("n", "<C-f>", "<cmd>silent !tmux neww tms<CR>")
vim.keymap.set("n", "<M-h>", "<cmd>silent !tmux neww tms -s 0<CR>")
vim.keymap.set("n", "<M-t>", "<cmd>silent !tmux neww tms -s 1<CR>")
vim.keymap.set("n", "<M-n>", "<cmd>silent !tmux neww tms -s 2<CR>")
vim.keymap.set("n", "<M-s>", "<cmd>silent !tmux neww tms -s 3<CR>")
