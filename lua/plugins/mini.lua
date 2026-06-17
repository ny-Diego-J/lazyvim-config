return {
	{
		"echasnovski/mini.nvim",
		version = false,
		event = "VeryLazy",
		config = function()
			-------------------------------------------------------------------------
			-- 1. CONFIG FOR MINI.AI (Erweiterte Textobjekte)
			-------------------------------------------------------------------------
			local ai = require("mini.ai")

			-- Helferfunktion: Berechnet das gesamte Buffer-Textobjekt (g)
			local function ai_buffer(ai_type)
				local start_line, end_line = 1, vim.fn.line("$")
				if ai_type == "i" then
					local first_nonblank, last_nonblank = vim.fn.nextnonblank(start_line), vim.fn.prevnonblank(end_line)
					if first_nonblank == 0 or last_nonblank == 0 then
						return { from = { line = start_line, col = 1 } }
					end
					start_line, end_line = first_nonblank, last_nonblank
				end
				local to_col = math.max(vim.fn.getline(end_line):len(), 1)
				return { from = { line = start_line, col = 1 }, to = { line = end_line, col = to_col } }
			end

			-- Setup von mini.ai mit intelligenten Standard-Objekten
			ai.setup({
				n_lines = 500,
				custom_textobjects = {
					o = ai.gen_spec.treesitter({ -- Blöcke, Schleifen, Conditionals
						a = { "@conditional.outer", "@loop.outer" },
						i = { "@conditional.inner", "@loop.inner" },
					}),
					c = ai.gen_spec.treesitter({ a = "@class.outer", i = "@class.inner" }), -- Klassen
					f = ai.gen_spec.treesitter({ a = "@function.outer", i = "@function.inner" }), -- Funktionen
					g = ai_buffer, -- Das gesamte File via 'g'
				},
			})

			-- Which-Key Integration für Textobjekte
			local function register_ai_whichkey()
				local objects = {
					{ " ", desc = "whitespace" },
					{ '"', desc = '" string' },
					{ "'", desc = "' string" },
					{ "(", desc = "() block" },
					{ ")", desc = "() block with ws" },
					{ "<", desc = "<> block" },
					{ ">", desc = "<> block with ws" },
					{ "?", desc = "user prompt" },
					{ "U", desc = "use/call without dot" },
					{ "[", desc = "[] block" },
					{ "]", desc = "[] block with ws" },
					{ "_", desc = "underscore" },
					{ "`", desc = "` string" },
					{ "a", desc = "argument" },
					{ "b", desc = ")]} block" },
					{ "c", desc = "class" },
					{ "d", desc = "digit(s)" },
					{ "e", desc = "CamelCase / snake_case" },
					{ "f", desc = "function" },
					{ "g", desc = "entire file" },
					{ "i", desc = "indent" },
					{ "o", desc = "block, conditional, loop" },
					{ "q", desc = "quote `\"'" },
					{ "t", desc = "tag" },
					{ "u", desc = "use/call" },
					{ "{", desc = "{} block" },
					{ "}", desc = "{} with ws" },
				}

				local ret = { mode = { "o", "x" } }
				local mappings = {
					around = "a",
					inside = "i",
					around_next = "an",
					inside_next = "in",
					around_last = "al",
					inside_last = "il",
				}

				for name, prefix in pairs(mappings) do
					name = name:gsub("^around_", ""):gsub("^inside_", "")
					table.insert(ret, { prefix, group = name })
					for _, obj in ipairs(objects) do
						local desc = obj.desc
						if prefix:sub(1, 1) == "i" then
							desc = desc:gsub(" with ws", "")
						end
						table.insert(ret, { prefix .. obj[1], desc = desc })
					end
				end

				local ok, wk = pcall(require, "which-key")
				if ok then
					wk.add(ret, { notify = false })
				end
			end

			register_ai_whichkey()

			-------------------------------------------------------------------------
			-- 2. CONFIG FOR MINI.PAIRS (Autopairs mit intelligenten Skips)
			-------------------------------------------------------------------------
			local pairs = require("mini.pairs")

			-- Deine gewünschten Filter-Optionen aus LazyVim
			local pairs_opts = {
				skip_next = [=[[%w%%%'%[%"%.%`%$]]=],
				skip_ts = { "string" },
				skip_unbalanced = true,
				markdown = true,
			}

			pairs.setup({}) -- Initiales Basis-Setup

			-- Überschreiben der Open-Logik für smartes Überspringen
			local open = pairs.open
			pairs.open = function(pair, neigh_pattern)
				if vim.fn.getcmdline() ~= "" then
					return open(pair, neigh_pattern)
				end

				local o, c = pair:sub(1, 1), pair:sub(2, 2)
				local line = vim.api.nvim_get_current_line()
				local cursor = vim.api.nvim_win_get_cursor(0)
				local next_char = line:sub(cursor[2] + 1, cursor[2] + 1)
				local before = line:sub(1, cursor[2])

				-- Smart Markdown Code-Blocks (Erzeugt automatisch schließende ```)
				if pairs_opts.markdown and o == "`" and vim.bo.filetype == "markdown" and before:match("^%s*``") then
					return "`\n```" .. vim.api.nvim_replace_termcodes("<up>", true, true, true)
				end
				-- Überspringen, wenn das nächste Zeichen ein Buchstabe/Zahl/etc. ist
				if pairs_opts.skip_next and next_char ~= "" and next_char:match(pairs_opts.skip_next) then
					return o
				end
				-- Überspringen, wenn wir uns laut Treesitter in einem String befinden
				if pairs_opts.skip_ts and #pairs_opts.skip_ts > 0 then
					local ts_ok, captures =
						pcall(vim.treesitter.get_captures_at_pos, 0, cursor[1] - 1, math.max(cursor[2] - 1, 0))
					for _, capture in ipairs(ts_ok and captures or {}) do
						if vim.tbl_contains(pairs_opts.skip_ts, capture.capture) then
							return o
						end
					end
				end
				-- Überspringen, wenn die Klammern unbalanciert sind
				if pairs_opts.skip_unbalanced and next_char == c and c ~= o then
					local _, count_open = line:gsub(vim.pesc(pair:sub(1, 1)), "")
					local _, count_close = line:gsub(vim.pesc(pair:sub(2, 2)), "")
					if count_close > count_open then
						return o
					end
				end

				return open(pair, neigh_pattern)
			end

			-- Manueller Toggle-Keymap anstelle von Snacks.nvim (<leader>up schaltet Autopairs um)
			vim.keymap.set("n", "<leader>up", function()
				vim.g.minipairs_disable = not vim.g.minipairs_disable
				print("MiniPairs " .. (vim.g.minipairs_disable and "deaktiviert" or "aktiviert"))
			end, { desc = "Toggle Auto Pairs" })
		end,
	},
}
