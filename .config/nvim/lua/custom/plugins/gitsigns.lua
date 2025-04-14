return { -- Adds git related signs to the gutter, as well as utilities for managing changes
	"lewis6991/gitsigns.nvim",
	opts = {
		signs = {
			add = { text = "+" },
			change = { text = "~" },
			delete = { text = "_" },
			topdelete = { text = "‾" },
			changedelete = { text = "~" },
		},
		current_line_blame = true, -- Toggle with `:Gitsigns toggle_current_line_blame`
		current_line_blame_opts = {
			virt_text = true,
			virt_text_pos = "eol", -- 'eol' | 'overlay' | 'right_align'
			delay = 500, -- unit in ms
			ignore_whitespace = false,
			virt_text_priority = 200,
		},
		current_line_blame_formatter = "  <author>, <author_time:%Y-%m-%d> - <summary>",
		max_file_length = 40000, -- Disable if file is longer than this (in lines)
	},
}
