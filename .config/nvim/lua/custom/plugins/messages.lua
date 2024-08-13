return {
	"AckslD/messages.nvim",
	lazy = true,
	keys = {
		{ "<leader>m", "<cmd>Messages messages<CR>", desc = "[M]essages in a float" },
	},
	config = function()
		require("messages").setup({
			buffer_name = "float_messages",
			post_open_float = function(winnr)
				vim.keymap.set({ "n" }, "qq", function()
					local buf = vim.api.nvim_win_get_buf(winnr)
					vim.api.nvim_buf_delete(buf, {})
				end, { desc = "[M]essages easy close" })
			end,
		})
	end,
}
