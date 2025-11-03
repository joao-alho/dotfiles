return {
	{
		dir = "~/projects/nvim/nvim-dbee/",
		lazy = true,
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
						{ key = "<leader>pn", mode = "", action = "page_next" },
						{ key = "<leader>pp", mode = "", action = "page_prev" },
						{ key = "<leader>pl", mode = "", action = "page_last" },
						{ key = "<leader>pf", mode = "", action = "page_first" },
						-- yank rows as csv/json
						{ key = "<leader>yj", mode = "n", action = "yank_current_json" },
						{ key = "<leader>yj", mode = "v", action = "yank_selection_json" },
						{ key = "<leader>YJ", mode = "", action = "yank_all_json" },
						{ key = "<leader>yc", mode = "n", action = "yank_current_csv" },
						{ key = "<leader>yc", mode = "v", action = "yank_selection_csv" },
						{ key = "<leader>YC", mode = "", action = "yank_all_csv" },

						-- cancel current call execution
						{ key = "<C-c>", mode = "", action = "cancel_call" },
					},
				},
				default_connection = "memory_source_athena_nx1",
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
							id = "athena_nx_us",
							name = "athena_nx_us",
							type = "athena",
							url = "awsathena://us-east-2?work_group=nxAthena-v1&read_only=false",
						},
					}, "athena_nx_us"),
					source.MemorySource:new({
						{
							id = "athena_nx",
							name = "athena_nx",
							type = "athena",
							url = "awsathena://eu-central-1?work_group=nxAthena-v1&read_only=false",
						},
					}, "athena_nx"),
					require("dbee.sources").EnvSource:new("DBEE_CONNECTIONS"),
				},
			})
			require("custom.dbee")
		end,
	},
}
