return {
	{
		"Vigemus/iron.nvim",
		opts = {},
		config = function()
			local iron = require("iron.core")

			iron.setup({
				config = {
					scratch_repl = true,
					repl_definition = {
						scala = {
							command = { "docker", "exec", "-it", "devices", "./iceberg-shell.sh" },
						},
					},
					ignore_blank_lines = true,
					repl_open_cmd = require("iron.view").bottom(10),
				},
				ignore_blank_lines = true,
			})
			require("custom.iron")
		end,
	},
}
