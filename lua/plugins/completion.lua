return {
	{
		"hrsh7th/nvim-cmp",
		event = { "InsertEnter", "CmdlineEnter" },
		dependencies = {
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-path",
			"hrsh7th/cmp-cmdline",
		},
		config = function()
			local cmp = require("cmp")
			local Kind = cmp.lsp.CompletionItemKind

			-------------------------------------------------------------------------
			-- HELFER-FUNKTIONEN (Das Tuning-Kit aus LazyVim, angepasst für reines Neovim)
			-------------------------------------------------------------------------

			-- 1. Automatisches Einfügen von Klammern () bei Funktionen/Methoden
			local function auto_brackets(entry)
				local item = entry:get_completion_item()
				if vim.tbl_contains({ Kind.Function, Kind.Method }, item.kind) then
					local cursor = vim.api.nvim_win_get_cursor(0)
					local prev_char =
						vim.api.nvim_buf_get_text(0, cursor[1] - 1, cursor[2], cursor[1] - 1, cursor[2] + 1, {})[1]
					if prev_char ~= "(" and prev_char ~= ")" then
						local keys = vim.api.nvim_replace_termcodes("()<left>", false, false, true)
						vim.api.nvim_feedkeys(keys, "i", true)
					end
				end
			end

			-- 2. Snippet-Grammatik-Parser für die Live-Vorschau
			local function snippet_preview(snippet)
				local ok, parsed = pcall(function()
					return vim.lsp._snippet_grammar.parse(snippet)
				end)
				if ok and parsed then
					return tostring(parsed)
				end
				-- Fallback Clean-up, falls der interne Parser fehlt
				return snippet:gsub("%$%b{}", ""):gsub("%$0", "")
			end

			-- 3. Fehlende Dokumentationen für Snippets on-the-fly generieren
			local function add_missing_snippet_docs(window)
				local entries = window:get_entries()
				for _, entry in ipairs(entries) do
					if entry:get_kind() == Kind.Snippet then
						local item = entry:get_completion_item()
						if not item.documentation and item.insertText then
							item.documentation = {
								kind = cmp.lsp.MarkupKind.Markdown,
								value = string.format(
									"```%s\n%s\n```",
									vim.bo.filetype,
									snippet_preview(item.insertText)
								),
							}
						end
					end
				end
			end

			-- 4. Optimierter Confirm-Befehl (Schneller + erzeugt sauberen Undo-Punkt)
			local function smart_confirm(opts)
				opts = vim.tbl_extend("force", {
					select = true,
					behavior = cmp.ConfirmBehavior.Insert,
				}, opts or {})
				return function(fallback)
					if cmp.core.view:visible() or vim.fn.pumvisible() == 1 then
						-- Erzeugt einen echten atomaren Undo-Punkt in Neovim vor dem Insert
						vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<c-G>u", true, true, true), "n", true)
						if cmp.confirm(opts) then
							return
						end
					end
					return fallback()
				end
			end

			-------------------------------------------------------------------------
			-- MAIN CMP SETUP
			-------------------------------------------------------------------------
			cmp.setup({
				-- Nutzen der nativen Neovim 0.10+ Snippet-Engine
				snippet = {
					expand = function(args)
						vim.snippet.expand(args.body)
					end,
				},

				-- Deine gewünschten Mappings kombiniert mit dem schnellen Smart-Confirm
				mapping = cmp.mapping.preset.insert({
					["<C-b>"] = cmp.mapping.scroll_docs(-4),
					["<C-f>"] = cmp.mapping.scroll_docs(4),
					["<C-Space>"] = cmp.mapping.complete(),

					-- Hier nutzen wir die optimierte Bestätigung mit automatischem Undo-Punkt
					["<CR>"] = smart_confirm({ select = true }),

					-- Navigation via Tab durch das Menü und native Snippets
					["<Tab>"] = cmp.mapping(function(fallback)
						if cmp.visible() then
							cmp.select_next_item()
						elseif vim.snippet.active({ direction = 1 }) then
							vim.schedule(function()
								vim.snippet.jump(1)
							end)
						else
							fallback()
						end
					end, { "i", "s" }),

					["<S-Tab>"] = cmp.mapping(function(fallback)
						if cmp.visible() then
							cmp.select_prev_item()
						elseif vim.snippet.active({ direction = -1 }) then
							vim.schedule(function()
								vim.snippet.jump(-1)
							end)
						else
							fallback()
						end
					end, { "i", "s" }),
				}),

				-- Deine definierten Quellen (LSP, Native Snippets, Buffers, Paths)
				sources = cmp.config.sources({
					{ name = "nvim_lsp" },
					{ name = "snippets" }, -- Nutzt die nativen Neovim-Snippets als Quelle
				}, {
					{ name = "buffer" },
					{ name = "path" },
				}),
			})

			-------------------------------------------------------------------------
			-- EVENTS & CMDLINE (Einbindung der Tuning-Features)
			-------------------------------------------------------------------------

			-- Aktiviert die Auto-Brackets, sobald ein Vorschlag bestätigt wurde
			cmp.event:on("confirm_done", function(event)
				auto_brackets(event.entry)
			end)

			-- Schaltet die Markdown-Snippet-Vorschau im Doku-Fenster an
			cmp.event:on("menu_opened", function(event)
				add_missing_snippet_docs(event.window)
			end)

			-- Vervollständigung für Suche (/ und ?)
			cmp.setup.cmdline({ "/", "?" }, {
				mapping = cmp.mapping.preset.cmdline(),
				sources = {
					{ name = "buffer" },
				},
			})

			-- Vervollständigung für die Befehlszeile (:)
			cmp.setup.cmdline(":", {
				mapping = cmp.mapping.preset.cmdline(),
				sources = cmp.config.sources({
					{ name = "path" },
				}, {
					{ name = "cmdline" },
				}),
				matching = { disallow_symbol_nonprefix_matching = false },
			})

			-- Registriert die LSP Capabilities global (Vorbereitung für Neovim 0.11+)
			local ok, cmp_lsp = pcall(require, "cmp_nvim_lsp")
			if ok then
				vim.lsp.config("*", { capabilities = cmp_lsp.default_capabilities() })
			end
		end,
	},
}
