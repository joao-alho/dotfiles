return { -- Autocompletion
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
	},
	opts = {
		keymap = { preset = "default" },
		appearance = {
			nerd_font_variant = "mono",
		},
		completion = {
			-- By default, you may press `<c-space>` to show the documentation.
			-- Optionally, set `auto_show = true` to show the documentation after a delay.
			documentation = { auto_show = false, auto_show_delay_ms = 500 },
		},
		sources = {
			default = { "lsp", "path", "snippets", "lazydev" },
			providers = {
				lazydev = { module = "lazydev.integrations.blink", score_offset = 100 },
			},
		},
		snippets = { preset = "luasnip" },
		fuzzy = { implementation = "prefer_rust_with_warning" },
		-- Shows a signature help window while you type arguments for a function
		signature = { enabled = true },
	},
}
-- {
-- 	"hrsh7th/nvim-cmp",
-- 	event = "InsertEnter",
-- 	dependencies = {
-- 		-- Snippet Engine & its associated nvim-cmp source
-- 		{
-- 			"L3MON4D3/LuaSnip",
-- 			build = (function()
-- 				-- Build Step is needed for regex support in snippets
-- 				-- This step is not supported in many windows environments
-- 				-- Remove the below condition to re-enable on windows
-- 				if vim.fn.has("win32") == 1 or vim.fn.executable("make") == 0 then
-- 					return
-- 				end
-- 				return "make install_jsregexp"
-- 			end)(),
-- 		},
-- 		"saadparwaiz1/cmp_luasnip",
-- 		"hrsh7th/cmp-nvim-lsp",
-- 		"hrsh7th/cmp-path",
-- 		-- "hrsh7th/cmp-buffer",
-- 		{
-- 			-- "MattiasMTS/cmp-dbee",
-- 			dir = "~/projects/nvim/cmp-dbee/",
-- 			dependencies = {
-- 				{ "kndndrj/nvim-dbee" },
-- 			},
-- 			ft = "sql",
-- 			opts = {},
-- 		},
-- 	},
-- 	config = function()
-- 		local cmp = require("cmp")
-- 		local luasnip = require("luasnip")
-- 		luasnip.config.setup({})
--
-- 		cmp.setup({
-- 			sources = {
-- 				{ name = "nvim_lsp" },
-- 				{ name = "luasnip" },
-- 				{ name = "path" },
-- 				{ name = "buffer", max_item_count = 5 },
-- 				{ name = "cmp-dbee" },
-- 			},
-- 			snippet = {
-- 				expand = function(args)
-- 					luasnip.lsp_expand(args.body)
-- 				end,
-- 			},
-- 			completion = { completeopt = "menu,menuone,noinsert" },
--
-- 			mapping = cmp.mapping.preset.insert({
-- 				["<C-n>"] = cmp.mapping.select_next_item(),
-- 				["<C-p>"] = cmp.mapping.select_prev_item(),
-- 				["<C-b>"] = cmp.mapping.scroll_docs(-4),
-- 				["<C-f>"] = cmp.mapping.scroll_docs(4),
-- 				["<C-y>"] = cmp.mapping.confirm({ select = true }),
-- 				["<C-Space>"] = cmp.mapping.complete({}),
-- 				["<C-l>"] = cmp.mapping(function()
-- 					if luasnip.expand_or_locally_jumpable() then
-- 						luasnip.expand_or_jump()
-- 					end
-- 				end, { "i", "s" }),
-- 				["<C-h>"] = cmp.mapping(function()
-- 					if luasnip.locally_jumpable(-1) then
-- 						luasnip.jump(-1)
-- 					end
-- 				end, { "i", "s" }),
-- 			}),
-- 		})
-- 	end,
-- },
