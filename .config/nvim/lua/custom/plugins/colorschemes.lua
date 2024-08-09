return {
	{
		-- If you want to see what colorschemes are already installed, you can use `:Telescope colorscheme`
		-- "folke/tokyonight.nvim",
		"rose-pine/neovim",
		lazy = false, -- make sure we load this during startup if it is your main colorscheme
		priority = 1000, -- make sure to load this before all the other start plugins
		config = function()
			vim.cmd.colorscheme("rose-pine")
			-- You can configure highlights by doing something like
			vim.cmd.hi("Comment gui=none")
		end,
	},
}
