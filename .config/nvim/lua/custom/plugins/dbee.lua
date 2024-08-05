return {
	{
		"kndndrj/nvim-dbee",
		enabled = false,
		dependencies = { "MunifTanjim/nui.nvim" },
		build = function()
			require("dbee").install("go")
		end,
		config = function()
			local source = require("dbee.sources")
			require("dbee").setup({
				drawer = {
					disable_help = true,
				},
				editor = {
					mappings = {
						{ key = "BB", mode = "v", action = "run_selection" },
						{ key = "BB", mode = "n", action = "run_file" },
					},
				},
				result = {
					mappings = {
						{ key = "p", mode = "", action = "page_next" },
						{ key = "pp", mode = "", action = "page_prev" },
						{ key = "pl", mode = "", action = "page_last" },
						{ key = "pf", mode = "", action = "page_first" },
					},
				},
				sources = {
					source.MemorySource:new({
						---@diagnostic disable-next-line: missing-fields
						{
							type = "duckdb",
							name = "duckduck",
							url = "~/duck.db",
						},
					}),
				},
			})
			require("custom.dbee")
		end,
	},
}
