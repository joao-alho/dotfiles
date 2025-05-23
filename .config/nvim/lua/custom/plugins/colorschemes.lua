return {
	{
		-- If you want to see what colorschemes are already installed, you can use `:Telescope colorscheme`
		-- "folke/tokyonight.nvim",
		"rose-pine/neovim",
		lazy = false, -- make sure we load this during startup if it is your main colorscheme
		priority = 1000, -- make sure to load this before all the other start plugins
		config = function()
			local scheme = require("rose-pine")
			scheme.setup({
				enable = {
					terminal = true,
					italic = true,
					bold = true,
				},
				styles = {
					transparency = true,
				},
				dim_inactive_windows = false,
				extend_background_behind_borders = true,
			})
			vim.cmd.colorscheme("rose-pine")
			-- You can configure highlights by doing something like
			-- vim.cmd.hi("Comment gui=none")
		end,
	},
}
