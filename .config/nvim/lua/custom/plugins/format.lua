return {
	{ -- Autoformat
		"stevearc/conform.nvim",
		event = { "BufWritePre" },
		cmd = { "ConformInfo" },
		keys = {
			{
				"<leader>f",
				function()
					require("conform").format({ async = true, lsp_fallback = true }, function(err)
						if not err then
							local mode = vim.api.nvim_get_mode().mode
							if vim.startswith(string.lower(mode), "v") then
								vim.api.nvim_feedkeys(
									vim.api.nvim_replace_termcodes("<Esc>", true, false, true),
									"n",
									true
								)
							end
						end
					end)
				end,
				mode = "",
				desc = "[F]ormat buffer",
			},
		},
		opts = {
			notify_on_error = true,
			-- for slow formatters like sqlfluff I could use
			-- format_after_save instead, in any case I want to format
			-- selections and not entire files so this is better for now
			format_on_save = function(bufnr)
				if vim.o.filetype == "sql" then
					return
				end
				return {
					timeout_ms = 500,
					lsp_fallback = true,
				}
			end,
			formatters_by_ft = {
				lua = { "stylua" },
				python = { "ruff_format" },
				sql = { "sql_formatter" },
			},
			formatters = {
				sql_formatter = {
					append_args = {
						"-c",
						'{"language":"trino","tabWidth":2,"keywordCase":"upper","linesBetweenQueries":1,"dataTypeCase":"upper","functionCase":"lower","expressionWidth":80}',
					},
				},
			},
		},
	},
}
