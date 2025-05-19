local minifiles_toggle = function()
	if not MiniFiles.close() then
		MiniFiles.open()
	end
end

local minifiles_toggle_cwf = function()
	if not MiniFiles.close() then
		MiniFiles.open(vim.api.nvim_buf_get_name(0), false)
		vim.schedule(function()
			MiniFiles.reveal_cwd()
		end)
	end
end

vim.keymap.set("n", "-", minifiles_toggle, { desc = "Open mini.files" })
vim.keymap.set("n", "-f", minifiles_toggle_cwf, { desc = "Open mini.files in current working file" })

local show_dotfiles = true

local filter_show = function(fs_entry)
	return true
end

local filter_hide = function(fs_entry)
	return not vim.startswith(fs_entry.name, ".")
end

local toggle_dotfiles = function()
	show_dotfiles = not show_dotfiles
	local new_filter = show_dotfiles and filter_show or filter_hide
	MiniFiles.refresh({ content = { filter = new_filter } })
end

vim.api.nvim_create_autocmd("User", {
	pattern = "MiniFilesBufferCreate",
	callback = function(args)
		local buf_id = args.data.buf_id
		-- Tweak left-hand side of mapping to your liking
		vim.keymap.set("n", "g.", toggle_dotfiles, { buffer = buf_id })
	end,
})
