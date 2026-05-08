-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
vim.o.guifont = "JetBrainsMono Nerd Font:h13"

-- make tab spacing 4 chars
vim.opt.shiftwidth = 4
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.expandtab = true

vim.diagnostic.config({
    virtual_text = true,
    update_in_insert = false,
})

-- zooming in and out
vim.g.neovide_scale_factor = 1.0
local change_scale_factor = function(delta)
    vim.g.neovide_scale_factor = vim.g.neovide_scale_factor * delta
end
local reset_scale_factor = function()
    vim.g.neovide_scale_factor = 1.0
end
vim.keymap.set("n", "<C-9>", function()
    change_scale_factor(1.10)
end)
vim.keymap.set("n", "<C-->", function()
    change_scale_factor(1 / 1.10)
end)
vim.keymap.set("n", "<C-0>", function()
    reset_scale_factor()
end)

vim.api.nvim_create_autocmd("ColorScheme", {
    pattern = "*",
    callback = function()
        vim.api.nvim_set_hl(0, "@lsp.type.modifier.java", {})
        vim.api.nvim_set_hl(0, "@lsp.type.keyword.java", {})
    end,
})

-- Attemt to make two coloscheme that dissables the blurr on toggle
-- Windows doens't allow that
vim.g.neovide_window_blurred = true

local setTransparent = function()
    if vim.g.neovide_opacity == 0.0 then
        vim.g.neovide_window_blurred = true
        vim.g.neovide_opacity = 0.8
        vim.cmd.colorscheme("tokyonight-moon")
    else
        vim.g.neovide_opacity = 0.0
        vim.g.neovide_window_blurred = false
        vim.cmd.colorscheme("zaibatsu")
    end
    vim.cmd("redraw!")
end

if vim.g.neovide then
    vim.g.neovide_opacity = 0.8
    vim.keymap.set("n", "<F12>", function()
        setTransparent()
    end)
end
