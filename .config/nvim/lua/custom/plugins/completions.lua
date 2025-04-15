return {
	{
		"saghen/blink.compat",
		version = "*",
		lazy = true,
		opts = {},
	},
	{ -- Autocompletion
		"saghen/blink.cmp",
		event = "VimEnter",
		version = "1.*",
		dependencies = {
			-- Snippet Engine
			{
				"L3MON4D3/LuaSnip",
				version = "2.*",
				build = (function()
					-- Build Step is needed for regex support in snippets.
					-- This step is not supported in many windows environments.
					-- Remove the below condition to re-enable on windows.
					if vim.fn.has("win32") == 1 or vim.fn.executable("make") == 0 then
						return
					end
					return "make install_jsregexp"
				end)(),
				dependencies = {
					-- `friendly-snippets` contains a variety of premade snippets.
					--    See the README about individual language/framework/plugin snippets:
					--    https://github.com/rafamadriz/friendly-snippets
					-- {
					--   'rafamadriz/friendly-snippets',
					--   config = function()
					--     require('luasnip.loaders.from_vscode').lazy_load()
					--   end,
					-- },
				},
				opts = {},
			},
			"folke/lazydev.nvim",
			"xzbdmw/colorful-menu.nvim",
			{
				dir = "~/projects/nvim/cmp-dbee",
				enabled = true,
				ft = { "sql" },
				dev = true,
				dependencies = { "kndndrj/nvim-dbee" },
				opts = {},
			},
		},
		opts = {
			sources = {
				default = { "lsp", "path", "snippets" },
				per_filetype = { lua = { "lazydev" }, sql = { "dbee", "buffer" } },
				providers = {
					lazydev = { module = "lazydev.integrations.blink", score_offset = 100 },
					dbee = { name = "cmp-dbee", module = "blink.compat.source" },
				},
			},
			keymap = {
				preset = "default",
				["<C-space>"] = { "show" },
			},
			appearance = {
				nerd_font_variant = "mono",
			},
			completion = {
				documentation = { auto_show = false, window = { border = "single" } },
				list = {
					selection = {
						preselect = false,
						auto_insert = false,
					},
				},
				menu = {
					auto_show = false,
					draw = {
						columns = { { "kind_icon" }, { "label", gap = 1 } },
						components = {
							label = {
								text = function(ctx)
									return require("colorful-menu").blink_components_text(ctx)
								end,
								highlight = function(ctx)
									return require("colorful-menu").blink_components_highlight(ctx)
								end,
							},
						},
						treesitter = { "lsp" },
					},
					border = "rounded",
				},
				ghost_text = { show_with_menu = false },
			},
			snippets = { preset = "luasnip" },
			fuzzy = { implementation = "prefer_rust_with_warning" },
			signature = { enabled = true, window = { border = "single" } },
		},
	},
}
