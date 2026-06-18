return {
    {
        "folke/tokyonight.nvim",
        lazy = false,
        priority = 1000,
        opts = { style = "moon" },
        config = function(_, opts)
            require("tokyonight").setup(opts)
            --vim.cmd.colorscheme("tokyonight")
        end,
    },

    {
	"rose-pine/neovim",
	name = "rose-pine",
	config = function()
		vim.cmd("colorscheme rose-pine-main")
	end
    },
}
