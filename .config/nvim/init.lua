--  NOTE: Must happen before plugins are loaded (otherwise wrong leader will be used)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- [[ Setting options ]]
-- See `:help vim.opt`
--  For more options, you can see `:help option-list`

-- Make line numbers default
vim.opt.number = true
vim.opt.relativenumber = true

-- Enable mouse mode, can be useful for resizing splits for example!
vim.opt.mouse = "a"

-- Don't show the mode, since it's already in status line
vim.opt.showmode = false
-- Sync clipboard between OS and Neovim.
--  See `:help 'clipboard'`
vim.opt.clipboard = "unnamedplus"
if string.find(vim.loop.os_uname().release, "WSL2") ~= nil then
	-- stylua: ignore start
	vim.g.clipboard = {
		name = "wsl clipboard",
		copy = { ["+"] = { "clip.exe" }, ["*"] = { "clip.exe" } },
		paste = {
			["+"] = { 'powershell.exe', '-NoLogo', '-NoProfile', '-Command', '[Console]::Out.Write($(Get-Clipboard -Raw).tostring().replace("`r",""))' },
			["*"] = { 'powershell.exe', '-NoLogo', '-NoProfile', '-Command', '[Console]::Out.Write($(Get-Clipboard -Raw).tostring().replace("`r",""))' }
		},
		cache_enabled = 0,
	}
	-- stylua: ignore end
end

-- Enable break indent
vim.opt.breakindent = true

-- Save undo history
vim.opt.undofile = true

-- Case-insensitive searching UNLESS \C or capital in search
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Keep signcolumn on by default
vim.opt.signcolumn = "yes"

-- Decrease update time
vim.opt.updatetime = 250
vim.opt.timeoutlen = 300

-- Configure how new splits should be opened
vim.opt.splitright = true
vim.opt.splitbelow = true

-- Preview substitutions live, as you type!
vim.opt.inccommand = "split"

-- Show which line your cursor is on
vim.opt.cursorline = true
vim.opt.winborder = "single"

-- Minimal number of screen lines to keep above and below the cursor.
vim.opt.scrolloff = 10
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.hlsearch = true

-- Set highlight on search, but clear on pressing <Esc> in normal mode
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")

-- Diagnostic keymaps
-- vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, { desc = "Go to previous [D]iagnostic message" })
-- vim.keymap.set("n", "]d", vim.diagnostic.goto_next, { desc = "Go to next [D]iagnostic message" })
vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, { desc = "Show diagnostic [E]rror messages" })
vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Open diagnostic [Q]uickfix list" })
vim.keymap.set("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })

-- Disable arrow keys in normal mode
vim.keymap.set("n", "<left>", '<cmd>echo "Use h to move!!"<CR>')
vim.keymap.set("n", "<right>", '<cmd>echo "Use l to move!!"<CR>')
vim.keymap.set("n", "<up>", '<cmd>echo "Use k to move!!"<CR>')
vim.keymap.set("n", "<down>", '<cmd>echo "Use j to move!!"<CR>')

--  See `:help wincmd` for a list of all window commands
vim.keymap.set("n", "<C-h>", "<C-w><C-h>", { desc = "Move focus to the left window" })
vim.keymap.set("n", "<C-l>", "<C-w><C-l>", { desc = "Move focus to the right window" })
vim.keymap.set("n", "<C-j>", "<C-w><C-j>", { desc = "Move focus to the lower window" })
vim.keymap.set("n", "<C-k>", "<C-w><C-k>", { desc = "Move focus to the upper window" })

-- Center window when moving up and down or searching
vim.keymap.set({ "n", "v" }, "j", "jzz", { noremap = true })
vim.keymap.set({ "n", "v" }, "k", "kzz", { noremap = true })
vim.keymap.set({ "n", "v" }, "<C-u>", "<C-u>zz", { desc = "Remap jump half-page and center", noremap = true })
vim.keymap.set({ "n", "v" }, "<C-d>", "<C-d>zz", { desc = "Remap jump half-page and center", noremap = true })
vim.keymap.set({ "n", "v" }, "G", "Gzz", { desc = "Remap jump to end of buffer and center", noremap = true })
vim.keymap.set({ "n", "v", "o" }, "H", "^", { desc = "Remap jump to first non empty char of line", noremap = true })
vim.keymap.set({ "n", "v", "o" }, "L", "$", { desc = "Remap jump to end of line", noremap = true })
vim.keymap.set("n", "<leader>o", "i<CR><Esc>O", { desc = "Insert line at cursor" })

-- Highlight when yanking (copying) text
vim.api.nvim_create_autocmd("TextYankPost", {
	desc = "Highlight when yanking (copying) text",
	group = vim.api.nvim_create_augroup("kickstart-highlight-yank", { clear = true }),
	callback = function()
		vim.hl.on_yank()
	end,
})

-- Create a terminal buffer
vim.keymap.set("n", "<leader>tt", function()
	-- create a new window
	vim.cmd.new()
	-- move window to below current
	vim.cmd.wincmd("J")
	vim.api.nvim_win_set_height(0, 14)
	-- launch terminal in current window
	vim.cmd.term()
	vim.wo.number = false
	vim.wo.relativenumber = false
	vim.wo.scrolloff = 0
	vim.bo.filetype = "terminal"
	vim.cmd.startinsert()
end, { desc = "Open [T]erminal in new window" })

vim.api.nvim_create_autocmd("TermClose", {
	desc = "On terminal close, close window",
	group = vim.api.nvim_create_augroup("kickstart-term", { clear = true }),
	callback = function()
		vim.cmd.exit()
		vim.cmd.enter()
	end,
})

vim.api.nvim_create_autocmd("WinEnter", {
	desc = "On enter terminal set insert mode",
	group = vim.api.nvim_create_augroup("kickstart-term", { clear = true }),
	pattern = "term://*",
	callback = function()
		vim.cmd.startinsert()
	end,
})

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	local lazyrepo = "https://github.com/folke/lazy.nvim.git"
	vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
end ---@diagnostic disable-next-line: undefined-field
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
	"tpope/vim-sleuth", -- Detect tabstop and shiftwidth automatically
	{ -- Highlight todo, notes, etc in comments
		"folke/todo-comments.nvim",
		event = "VimEnter",
		dependencies = { "nvim-lua/plenary.nvim" },
		opts = { signs = false },
	},
	{ import = "custom/plugins" },
}, { change_detection = { notify = false } })
