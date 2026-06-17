-- 1. Bootstrap: Installiert lazy.nvim automatisch, falls es noch nicht existiert
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Fehler beim Klonen von lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nDrücke eine beliebige Taste zum Beenden...", "MoreMsg" },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end

-- 2. Füge lazy.nvim zum Laufzeitpfad (runtimepath) von Neovim hinzu
vim.opt.rtp:prepend(lazypath)

-- 3. Starte den Plugin-Manager mit deinen Plugins und Einstellungen
require("lazy").setup({
  spec = {
    -- Hier importierst du deine Plugin-Ordner. 
    -- Lazy durchsucht automatisch lua/plugins/ für dich.
 { import = "plugins" },

  },
  
  -- 4. Optionale, aber empfohlene UI- und System-Einstellungen
  defaults = {
    -- Plugins werden standardmäßig nicht sofort geladen (Lazy Loading),
    -- es sei denn, ein Plugin setzt `lazy = false`.
    lazy = true,
  },
  checker = {
    -- Überprüft im Hintergrund automatisch nach Plugin-Updates
    enabled = true,
    notify = false, -- Nervt nicht mit Popups bei jedem Start
  },
  performance = {
    rtp = {
      -- Deaktiviert eingebaute Neovim-Plugins, die man selten braucht,
      -- um den Startvorgang noch schneller zu machen.
      disabled_plugins = {
        "gzip",
        "tarPlugin",
        "tohtml",
        "tutor",
        "zipPlugin",
      },
    },
  },
})
