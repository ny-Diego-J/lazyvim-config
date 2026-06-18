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
