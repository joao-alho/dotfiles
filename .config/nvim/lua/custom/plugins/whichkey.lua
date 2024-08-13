return {
	{ -- Useful plugin to show you pending keybinds.
		"folke/which-key.nvim",
		event = "VimEnter", -- Sets the loading event to 'VimEnter'
		lazy = true,
		opts = {
			icons = { mappings = false },
		},
		config = function() -- This is the function that runs, AFTER loading
			local wk = require("which-key")
			wk.setup({
				icons = { mappings = false },
			})

			wk.add({
				{ "<leader>c", group = "[C]ode" },
				{ "<leader>d", group = "[D]oument" },
				{ "<leader>r", group = "[R]ename" },
				{ "<leader>s", group = "[S]earch" },
				{ "<leader>w", group = "[W]orkspace" },
				{ "<leader>t", group = "[T]erminal" },
				{ "<leader>d", group = "[D]bee", mode = { "n", "v" } },
				{ "K", desc = "Hover Documentation" },
			})
		end,
	},
}
