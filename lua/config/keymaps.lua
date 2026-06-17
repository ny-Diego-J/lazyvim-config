-- Keymaps are automatically loaded on the VeryLazy event
-- Add any additional keymaps here

local map = vim.keymap.set

--------------------------------------------------------------------------------
-- Ctrl+V Paste & Ctrl+Q Visual Block for Windows / Neovide Support
--------------------------------------------------------------------------------
-- Paste from system clipboard with Ctrl+v in insert and command-line modes
map({ "i", "c" }, "<C-v>", "<C-r>+", { desc = "Paste from Clipboard" })
-- Paste from system clipboard with Ctrl+v in normal mode
map("n", "<C-v>", '"+gP', { desc = "Paste from Clipboard" })
-- Remap Visual Block Mode to Ctrl+q since Ctrl+v is used for pasting
map("n", "<C-q>", "<C-v>", { desc = "Visual Block Mode" })

--------------------------------------------------------------------------------
-- Custom Keymaps
--------------------------------------------------------------------------------
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

-- Harpoon Setup & Mappings
local harpoon = require("harpoon")
harpoon.setup({})

map("n", "<leader>a", function()
    harpoon:list():add()
end, { desc = "Harpoon Add" })
map("n", "<C-e>", function()
    harpoon.ui:toggle_quick_menu(harpoon:list())
end, { desc = "Harpoon Menu" })

map("n", "<C-z>", function()
    harpoon:list():select(1)
end, { desc = "Harpoon file 1" })
map("n", "<C-t>", function()
    harpoon:list():select(2)
end, { desc = "Harpoon file 2" })
map("n", "<C-n>", function()
    harpoon:list():select(3)
end, { desc = "Harpoon file 3" })
map("n", "<C-s>", function()
    harpoon:list():select(4)
end, { desc = "Harpoon file 4" })

-- Toggle previous & next buffers stored within Harpoon list
map("n", "<C-S-P>", function()
    harpoon:list():prev()
end, { desc = "Harpoon Previous" })
map("n", "<C-S-N>", function()
    harpoon:list():next()
end, { desc = "Harpoon Next" })
