local iron = require("iron.core")
local ft = "scala"
local repl_on = false
local iron_win_nr = nil

-- implement a run query under buffer for nvim-dbee
-- only add this keymap when FileType is sql
local M = {}
function M.get_fn_definition()
	local ts_utils = require("nvim-treesitter.ts_utils")
	local current_node = ts_utils.get_node_at_cursor()

	local last_statement = nil
	while current_node do
		if current_node:type() == "function_definition" then
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
vim.keymap.set("n", "<leader>isf", function()
	local fn_definition = M.get_fn_definition()
	iron.send(ft, fn_definition)
end, { desc = "[I]ron [s]end [f]unction" })
vim.keymap.set("n", "<leader>is", iron.send_paragraph, { desc = "[I]ron [s]end paragraph" })
vim.keymap.set("n", "<leader>isl", iron.send_line, { desc = "[I]ron [s]end [l]ine" })
vim.keymap.set("v", "<leader>is", iron.visual_send, { desc = "[I]ron [s]end selection" })
vim.keymap.set("n", "<leader>ih", function()
	iron_win_nr = nil
	iron.hide_repl(ft)
end, { desc = "[I]ron [h]ide repl" })
vim.keymap.set("n", "<leader>if", function()
	if not repl_on then
		local imports =
			"import org.apache.spark.sql.SparkSession; import java.time.LocalDate; import org.apache.spark.sql.expressions.Window; import org.apache.spark.sql.functions._; import org.apache.spark.sql.types._; import org.apache.spark.sql.{DataFrame, Dataset, Column}"
		iron.send(ft, imports)
		iron.focus_on(ft)
		repl_on = true
	else
		iron.focus_on(ft)
	end
	if not iron_win_nr then
		iron_win_nr = vim.api.nvim_get_current_win()
	end
	vim.cmd.stopinsert()
end, { desc = "[I]ron [f]ocus repl" })
vim.keymap.set("n", "<leader>ic", function()
	iron.send(ft, ":quit")
	repl_on = false
	iron_win_nr = nil
end, { desc = "[I]ron [c]lose repl" })

vim.keymap.set("n", "<leader>ii", function()
	if not iron_win_nr then
		return
	end
	local cur_h = vim.api.nvim_win_get_height(iron_win_nr)
	if not (cur_h >= 50) then
		vim.api.nvim_win_set_height(iron_win_nr, cur_h + 10)
	end
end, { desc = "[I]ron [i]ncrease height" })
vim.keymap.set("n", "<leader>id", function()
	if not iron_win_nr then
		return
	end
	local cur_h = vim.api.nvim_win_get_height(iron_win_nr)
	if not (cur_h <= 10) then
		vim.api.nvim_win_set_height(iron_win_nr, cur_h - 10)
	end
end, { desc = "[I]ron [d]ecrease height" })
