return {
	{
		"kndndrj/nvim-dbee",
		enabled = true,
		dependencies = { "MunifTanjim/nui.nvim" },
		build = function()
			require("dbee").install()
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
				default_connection = "athena_nx",
				sources = {
					source.MemorySource:new({
						{
							id = "duckdb",
							type = "duckdb",
							name = "duckduck",
							url = "~/duck.db",
						},
					}, "duckduck"),
					source.MemorySource:new({
						{
							id = "athena_nx",
							name = "athena_nx",
							type = "athena",
							url = "athena://eu-central-1?work_group=nxAthena-v1",
						},
					}, "athena_nx"),
				},
			})
			require("custom.dbee")
		end,
	},
}
