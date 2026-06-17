return {
	"folke/which-key.nvim",
	event = "VeryLazy",
	opts = {
		-- Hier drin landen jetzt alle deine Konfigurationen direkt
		preset = "helix", -- Optionen: "classic", "modern", "helix"

		delay = function(ctx)
			return ctx.plugin and 0 or 200
		end,

		filter = function(mapping)
			return true
		end,

		spec = {},
		notify = true,

		triggers = {
			{ "<auto>", mode = "nxso" },
		},

		defer = function(ctx)
			return ctx.mode == "V" or ctx.mode == "<C-V>"
		end,

		plugins = {
			marks = true,
			registers = true,
			spelling = {
				enabled = true,
				suggestions = 20,
			},
			presets = {
				operators = true,
				motions = true,
				text_objects = true,
				windows = true,
				nav = true,
				z = true,
				g = true,
			},
		},

		win = {
			no_overlap = true,
			title = true,
			title_pos = "center",
			zindex = 1000,
			bo = {},
			wo = {},
		},

		keys = {
			scroll_down = "<c-d>",
			scroll_up = "<c-u>",
		},

		sort = { "local", "order", "group", "alphanum", "mod" },
		expand = 0,

		replace = {
			key = {
				function(key)
					return require("which-key.view").format(key)
				end,
			},
			desc = {
				{ "<Plug>%(?(.*)%)?", "%1" },
				{ "^%+", "" },
				{ "<[cC]md>", "" },
				{ "<[cC][rR]>", "" },
				{ "<[sS]ilent>", "" },
				{ "^lua%s+", "" },
				{ "^call%s+", "" },
				{ "^:%s*", "" },
			},
		},

		icons = {
			breadcrumb = "»",
			separator = "➜",
			group = "+",
			ellipsis = "…",
			mappings = true,
			rules = {},
			colors = true,
			keys = {
				Up = " ",
				Down = " ",
				Left = " ",
				Right = " ",
				C = "󰘴 ",
				M = "󰘵 ",
				D = "󰘳 ",
				S = "󰘶 ",
				CR = "󰌑 ",
				Esc = "󱊷 ",
				ScrollWheelDown = "󱕐 ",
				ScrollWheelUp = "󱕑 ",
				NL = "󰌑 ",
				BS = "󰁮",
				Space = "󱁐 ",
				Tab = "󰌒 ",
				F1 = "󱊫",
				F2 = "󱊬",
				F3 = "󱊭",
				F4 = "󱊮",
				F5 = "󱊯",
				F6 = "󱊰",
				F7 = "󱊱",
				F8 = "󱊲",
				F9 = "󱊳",
				F10 = "󱊴",
				F11 = "󱊵",
				F12 = "󱊶",
			},
		},

		show_help = true,
		show_keys = true,
		disable = { ft = {}, bt = {} },
		debug = false,
	},
	keys = {
		{
			"<leader>?",
			function()
				require("which-key").show({ global = false })
			end,
			desc = "show keymaps",
		},
	},
}
