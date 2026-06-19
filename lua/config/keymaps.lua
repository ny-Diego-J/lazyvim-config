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

map({ "n", "x" }, "<leader>re", function()
    return require("refactoring").extract_func()
end, { desc = "Extract Function", expr = true })
-- `_` is the default textobject for "current line"
map("n", "<leader>ree", function()
    return require("refactoring").extract_func() .. "_"
end, { desc = "Extract Function (line)", expr = true })

map({ "n", "x" }, "<leader>rE", function()
    return require("refactoring").extract_func_to_file()
end, { desc = "Extract Function To File", expr = true })

map({ "n", "x" }, "<leader>rv", function()
    return require("refactoring").extract_var()
end, { desc = "Extract Variable", expr = true })

-- `_` is the default textobject for "current line"
map("n", "<leader>rvv", function()
    return require("refactoring").extract_var() .. "_"
end, { desc = "Extract Variable (line)", expr = true })

map({ "n", "x" }, "<leader>ri", function()
    return require("refactoring").inline_var()
end, { desc = "Inline Variable", expr = true })
map({ "n", "x" }, "<leader>rI", function()
    return require("refactoring").inline_func()
end, { desc = "Inline function", expr = true })

map({ "n", "x" }, "<leader>rs", function()
    return require("refactoring").select_refactor()
end, { desc = "Select refactor" })

-- `iw` is the builtin textobject for "in word". You can use any other textobject or even create the keymap without any textobject if you prefer to provide one yourself each time that you use the keymap
map("n", "<leader>iv", function()
    return require("refactoring.debug").print_var({ output_location = "below" }) .. "iw"
end, { desc = "Debug print var below", expr = true })
map("x", "<leader>iv", function()
    return require("refactoring.debug").print_var({ output_location = "below" })
end, { desc = "Debug print var below", expr = true })

-- `iw` is the builtin textobject for "in word". You can use any other textobject or even create the keymap without any textobject if you prefer to provide one yourself each time that you use the keymap
map("n", "<leader>iV", function()
    return require("refactoring.debug").print_var({ output_location = "above" }) .. "iw"
end, { desc = "Debug print var above", expr = true })
map("x", "<leader>pV", function()
    return require("refactoring.debug").print_var({ output_location = "above" })
end, { desc = "Debug print var above", expr = true })

map({ "x", "n" }, "<leader>ie", function()
    return require("refactoring.debug").print_exp({ output_location = "below" })
end, { desc = "Debug print exp below", expr = true })
-- `_` is the default textobject for "current line"
map("n", "<leader>iee", function()
    return require("refactoring.debug").print_exp({ output_location = "below" }) .. "_"
end, { desc = "Debug print exp below", expr = true })

map({ "x", "n" }, "<leader>iE", function()
    return require("refactoring.debug").print_exp({ output_location = "above" })
end, { desc = "Debug print exp above", expr = true })
-- `_` is the default textobject for "current line"
map("n", "<leader>pEE", function()
    return require("refactoring.debug").print_exp({ output_location = "above" }) .. "_"
end, { desc = "Debug print exp above", expr = true })

map("n", "<leader>iP", function()
    return require("refactoring.debug").print_loc({ output_location = "above" })
end, { desc = "Debug print location", expr = true })
map("n", "<leader>pp", function()
    return require("refactoring.debug").print_loc({ output_location = "below" })
end, { desc = "Debug print location", expr = true })

map({ "x", "n" }, "<leader>ic", function()
    -- `ag` is a custom textobject that selects the whole buffer. It's provided by plugins like `mini.ai` (requires manual configuration using `MiniExtra.gen_ai_spec.buffer()`).
    -- return require("refactoring.debug").cleanup { restore_view = true } .. "ag"

    -- this keymap doesn't select any textobject by default, so you need to provide one each time you use it.
    return require("refactoring.debug").cleanup({ restore_view = true })
end, { desc = "Debug print clean", expr = true, remap = true })
