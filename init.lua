vim.env.PATH = vim.fn.stdpath("data") .. "/mason/bin:" .. vim.env.PATH
vim.g.mapleader = " "
vim.g.maplocalleader = " "
require("config.lazy")
require("config.keybinds")
require("config.options")
