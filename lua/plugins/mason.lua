return {
	{
		"mason-org/mason.nvim",
		cmd = "Mason",
		build = ":MasonUpdate",
		opts = {
			ui = {
				border = "rounded",
			},
		},
	},
	{
		-- Erweitert Mason, damit es die Formatter automatisch für dich installiert
		"zapling/mason-conform.nvim",
		dependencies = { "williamboman/mason.nvim", "stevearc/conform.nvim" },
		opts = {
			-- Hier trägst du genau die Formatter ein, die du in conform.nvim nutzt
			ensure_installed = {
				"clang-format",
				"stylua",
				"gofmt",
				"prettier",
				"shfmt",
			},
			automatic_installation = true,
		},
	},
}
