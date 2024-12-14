return {
	"Vigemus/iron.nvim",
	keys = { { "<leader>if", "<cmd>IronFocus scala<cr>", desc = "Iron" } },
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
	end,
}
