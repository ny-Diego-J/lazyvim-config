-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")

-- Wenn du einen 60Hz Monitor hast, setze 60. Bei 144Hz Monitor setze 144.
vim.g.neovide_refresh_rate = 60
vim.g.neovide_refresh_rate_idle = 5 -- Spart Akku, wenn du nichts tust
vim.g.neovide_vsync = false -- Testweise VSync deaktivieren

-- In deiner init.lua
vim.opt.tabstop = 4 -- Ein Tab wird als 4 Spalten angezeigt
vim.opt.softtabstop = 4 -- Wie viele Leerzeichen beim Drücken von Tab eingefügt werden
vim.opt.shiftwidth = 4 -- Größe der automatischen Einrückung (z.B. mit '>')
vim.opt.expandtab = true -- Verwandelt Tabs in echte Leerzeichen

vim.diagnostic.config({
    virtual_text = true,
    signs = true,
    underline = true,
})

if vim.g.neovide then
    vim.api.nvim_set_current_dir("C:\\Users\\digij")
end

require("conform").setup({
    formatters_by_ft = {
        javascript = { "prettier" },
        typescript = { "prettier" },
        html = { "prettier" },
        css = { "prettier" },
    },
    formatters = {
        prettier = {
            args = function(self, ctx)
                -- Check if the current file is HTML or CSS
                local ft = vim.bo[ctx.buf].filetype
                local width = "4" -- default

                if ft == "html" or ft == "css" then
                    width = "2"
                end

                return { "--stdin-filepath", "$FILENAME", "--tab-width", width }
            end,
        },
    },
})

if vim.g.neovide == true then
    vim.api.nvim_set_keymap("n", "<F11>", ":let g:neovide_fullscreen = !g:neovide_fullscreen<CR>", {})
end
