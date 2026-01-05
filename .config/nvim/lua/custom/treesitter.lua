local L = {
	"rust",
	"scala",
	"go",
	"lua",
	"sql",
	"python",
	"kotlin",
	"bash",
	"markdown",
	"markdown_inline",
	"vim",
	"vimdoc",
	"json",
	"toml",
	"yaml",
}
require("nvim-treesitter").install(L)
vim.api.nvim_create_autocmd("FileType", {
	pattern = L,
	callback = function()
		-- syntax highlighting, provided by Neovim
		vim.treesitter.start()
		-- folds, provided by Neovim
		vim.wo.foldexpr = "v:lua.vim.treesitter.foldexpr()"
		vim.wo.foldmethod = "expr"
		vim.wo.foldlevel = 99
		-- indentation, provided by nvim-treesitter
		-- vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
	end,
})
