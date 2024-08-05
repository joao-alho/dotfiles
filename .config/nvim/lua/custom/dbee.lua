local M = {}

function M.visual_selection()
	-- return to normal mode ('< and '> become available only after you exit visual mode)
	local key = vim.api.nvim_replace_termcodes("<esc>", true, false, true)
	vim.api.nvim_feedkeys(key, "x", false)

	local _, srow, scol, _ = unpack(vim.fn.getpos("'<"))
	local _, erow, ecol, _ = unpack(vim.fn.getpos("'>"))
	if ecol > 200000 then
		ecol = 20000
	end
	if srow < erow or (srow == erow and scol <= ecol) then
		return srow - 1, scol - 1, erow - 1, ecol
	else
		return erow - 1, ecol - 1, srow - 1, scol
	end
end

function M.run_current()
	local srow, scol, erow, ecol = M.visual_selection()
	local selection = vim.api.nvim_buf_get_text(0, srow, scol, erow, ecol, {})
	local query = table.concat(selection, "  ")
	return query
end

---@diagnostic disable-next-line: param-type-mismatch
local base = vim.fs.joinpath(vim.fn.stdpath("state"), "dbee", "notes")
local pattern = string.format("%s/.*", base)
vim.filetype.add({
	extension = {
		sql = function(path, _)
			if path:match(pattern) then
				return "sql.dbee"
			end

			return "sql"
		end,
	},

	pattern = {
		[pattern] = "sql.dbee",
	},
})

vim.keymap.set("n", "<space>dt", function()
	require("dbee").toggle()
end, { desc = "[D]bee [t]oggle" })
vim.api.nvim_create_autocmd({ "FileType" }, {
	desc = "On buffer enter with file type sql.dbee",
	group = vim.api.nvim_create_augroup("dbee", { clear = true }),
	pattern = { "sql.dbee" },
	callback = function()
		vim.keymap.set({ "n" }, "<space>de", function()
			vim.api.nvim_feedkeys("vip", "n", false)
			local s = M.run_current()
			local command = string.format("Dbee execute %s", s)
			-- vim.print(command)
			vim.api.nvim_command(command)
		end, { desc = "[D]bee [e]xecute query under cursor" })
	end,
})
