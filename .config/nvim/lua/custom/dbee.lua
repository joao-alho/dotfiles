vim.keymap.set("n", "<space>dt", function()
	require("dbee").toggle()
end, { desc = "[D]bee [t]oggle" })

-- implement a run query under buffer for nvim-dbee
-- only add this keymap when FileType is sql
vim.api.nvim_create_autocmd({ "FileType" }, {
	desc = "On buffer enter with file type sql",
	group = vim.api.nvim_create_augroup("dbee", { clear = true }),
	pattern = { "sql" },
	callback = function()
		local function run_current()
			local srow, scol, erow, ecol = require("dbee.utils").visual_selection()
			local selection = vim.api.nvim_buf_get_text(0, srow, scol, erow, ecol, {})
			local query = table.concat(selection, "\n")
			return query
		end
		vim.keymap.set({ "n" }, "<space>de", function()
			vim.api.nvim_feedkeys("vip", "n", false)
			local s = run_current()
			local command = string.format("Dbee execute %s", s)
			-- vim.print(command)
			vim.api.nvim_command(command)
		end, { desc = "[D]bee [e]xecute query under cursor" })
	end,
})
