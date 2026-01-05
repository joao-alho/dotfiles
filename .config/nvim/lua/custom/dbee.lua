vim.keymap.set("n", "<space>dt", function()
	local dbee = require("dbee")
	dbee.toggle()
	local conn = dbee.api.core.get_current_connection()
	dbee.api.core.connection_get_structure(conn.id)
end, { desc = "[D]bee [t]oggle" })

-- implement a run query under buffer for nvim-dbee
-- only add this keymap when FileType is sql
local M = {}
function M.get_query()
	-- local ts_utils = require("nvim-treesitter.ts_utils")
	-- local current_node = ts_utils.get_node_at_cursor()
	local current_node = vim.treesitter.get_node({ bufnr = 0, lang = "sql" })

	local last_statement = nil
	while current_node do
		if current_node:type() == "statement" then
			last_statement = current_node
		end
		if current_node:type() == "program" then
			break
		end
		current_node = current_node:parent()
	end

	if not last_statement then
		return ""
	end

	local srow, scol, erow, ecol = vim.treesitter.get_node_range(last_statement)
	local selection = vim.api.nvim_buf_get_text(0, srow, scol, erow, ecol, {})
	return table.concat(selection, "\n")
end

vim.api.nvim_create_autocmd({ "FileType" }, {
	desc = "On buffer enter with file type sql",
	group = vim.api.nvim_create_augroup("dbee", { clear = true }),
	pattern = { "sql" },
	callback = function()
		local dbee = require("dbee")
		vim.keymap.set({ "n" }, "<leader>de", function()
			local query = M.get_query()
			dbee.execute(query)
		end, { desc = "[D]bee [e]xecute query under cursor" })
		vim.keymap.set({ "n", "v" }, "<leader>df", function()
			vim.cmd("norm! f│")
		end, { desc = "[D]bee [f]orward one column" })
		vim.keymap.set({ "n", "v" }, "<leader>db", function()
			vim.cmd("norm! F│")
		end, { desc = "[D]bee [b]ackward one column" })
	end,
})
