local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
    local lazyrepo = "https://github.com/folke/lazy.nvim.git"
    local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
    if vim.v.shell_error ~= 0 then
        vim.api.nvim_echo({
            { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
            { out, "WarningMsg" },
            { "\nPress any key to exit..." },
        }, true, {})
        vim.fn.getchar()
        os.exit(1)
    end
end
vim.opt.rtp:prepend(lazypath)

-- Add LazyVim repository to rtp so modules can be required
local lazyvim_path = vim.fn.stdpath("data") .. "/lazy/LazyVim"
vim.opt.rtp:prepend(lazyvim_path)

require("lazy").setup({
    spec = {
        { "LazyVim/LazyVim", priority = 10000, lazy = false, opts = {} },
        { "wakatime/vim-wakatime", event = "VeryLazy" },
        -- import core plugins
        { import = "plugins.core" },
        -- import/override with your plugins
        { import = "plugins" },
    },
    defaults = {
        lazy = true,
        version = false,
        -- version = "*", -- try installing the latest stable version for plugins that support semver
    },
    install = { colorscheme = { "tokyonight", "habamax" } },
    checker = {
        enabled = false, -- check for plugin updates periodically
        notify = false, -- notify on update
    },
    performance = {
        rtp = {
            disabled_plugins = {
                "gzip",
                -- "matchit",
                -- "matchparen",
                -- "netrwPlugin",
                "tarPlugin",
                "tohtml",
                "tutor",
                "zipPlugin",
            },
        },
    },
})
