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

vim.keymap.set("n", "<F11>", function()
    vim.g.neovide_fullscreen = not vim.g.neovide_fullscreen
end, { desc = "Toggle Fullscreen" })

local harpoon = require("harpoon")

harpoon.setup({})

vim.keymap.set("n", "<leader>a", function()
    harpoon:list():add()
end)
vim.keymap.set("n", "<C-e>", function()
    harpoon.ui:toggle_quick_menu(harpoon:list())
end)

vim.keymap.set("n", "<C-a>", function()
    harpoon:list():select(1)
end)
vim.keymap.set("n", "<C-s>", function()
    harpoon:list():select(2)
end)
vim.keymap.set("n", "<C-d>", function()
    harpoon:list():select(3)
end)
vim.keymap.set("n", "<C-f>", function()
    harpoon:list():select(4)
end)

-- Toggle previous & next buffers stored within Harpoon list
vim.keymap.set("n", "<C-S-P>", function()
    harpoon:list():prev()
end)
vim.keymap.set("n", "<C-S-N>", function()
    harpoon:list():next()
end)
