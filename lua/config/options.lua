-- Basic Neovim defaults
local opt = vim.opt

opt.number = true             -- Show line numbers
opt.relativenumber = true     -- Relative line numbers
opt.clipboard = "unnamedplus"   -- Use system clipboard
opt.splitright = true         -- Vertical splits to the right
opt.splitbelow = true         -- Horizontal splits below
opt.undofile = true           -- Enable persistent undo
opt.ignorecase = true         -- Case insensitive searching
opt.smartcase = true          -- Case-sensitive if uppercase present
opt.mouse = "a"               -- Enable mouse support
opt.cursorline = true         -- Highlight the current line
opt.termguicolors = true      -- True color support
opt.signcolumn = "yes"        -- Always show signcolumn
opt.scrolloff = 8             -- Keep at least 8 lines above/below cursor
opt.updatetime = 250          -- Faster completion / diagnostic response

-- Custom options
vim.g.lazyvim_check_order = false
vim.o.guifont = "JetBrainsMono Nerd Font:h13"

-- make tab spacing 4 chars
vim.opt.shiftwidth = 4
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.expandtab = true

vim.g.neovide_refresh_rate = 60
vim.g.neovide_refresh_rate_idle = 5 -- Spart Akku, wenn du nichts tust
vim.g.neovide_vsync = false -- Testweise VSync deaktivieren

vim.diagnostic.config({
    virtual_text = true,
    update_in_insert = true,
    signs = true,
    underline = true,
})

if vim.g.neovide then
    vim.api.nvim_set_current_dir("C:\\Users\\digij")
end

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

-- Attemt to make two coloschemes that dissables the blurr on toggle
-- Windows doens't allow that
vim.g.neovide_window_blurred = true

local setTransparent = function()
    if vim.g.neovide_opacity == 0.0 then
        vim.g.neovide_window_blurred = true
        vim.g.neovide_opacity = 0.8
        vim.cmd.colorscheme("tokyonight-moon")
    else
        vim.g.neovide_opacity = 0.1
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

vim.g.netrw_banner = 0
vim.g.netrw_winsize = 50

-- vim.g.neovide_cursor_vfx_mode = "pixiedust" -- options: "railgun", "torpedo", "pixiedust", "sonicboom"

-- languages
vim.opt.spell = false
vim.opt.spelllang = { "en", "de", "fr" }
