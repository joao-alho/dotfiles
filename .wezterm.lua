local wezterm = require("wezterm")
local config = wezterm.config_builder()

config.color_scheme = "rose-pine"
config.window_background_opacity = 0.90
config.font = wezterm.font({ family = "JetBrains Mono", weight = "Regular" })
config.font_size = 12

config.enable_wayland = true
config.window_decorations = "NONE"
config.hide_tab_bar_if_only_one_tab = false
config.show_new_tab_button_in_tab_bar = false
config.window_frame = {
	font = wezterm.font({ family = "JetBrains Mono", weight = "Bold" }),
	font_size = 10,
}

config.wsl_domains = {
	{
		-- The name of this specific domain.  Must be unique amonst all types
		-- of domain in the configuration file.
		name = "WSL:Ubuntu",

		-- The name of the distribution.  This identifies the WSL distribution.
		-- It must match a valid distribution from your `wsl -l -v` output in
		-- order for the domain to be useful.
		distribution = "Ubuntu",

		-- The username to use when spawning commands in the distribution.
		-- If omitted, the default user for that distribution will be used.

		-- username = "hunter",

		-- The current working directory to use when spawning commands, if
		-- the SpawnCommand doesn't otherwise specify the directory.

		default_cwd = "~",
	},
}

if wezterm.target_triple == "x86_64-pc-windows-msvc" then
	config.default_domain = "WSL:Ubuntu"
	config.window_decorations = "RESIZE"
end

wezterm.on("update-status", function(window)
	-- Grab the utf8 character for the "powerline" left facing
	-- solid arrow.
	local SOLID_LEFT_ARROW = utf8.char(0xe0b2)

	-- Grab the current window's configuration, and from it the
	-- palette (this is the combination of your chosen colour scheme
	-- including any overrides).
	local color_scheme = window:effective_config().resolved_palette
	local bg = color_scheme.background
	local fg = color_scheme.foreground

	window:set_right_status(wezterm.format({
		-- First, we draw the arrow...
		{ Background = { Color = "none" } },
		{ Foreground = { Color = bg } },
		{ Text = SOLID_LEFT_ARROW },
		-- Then we draw our text
		{ Background = { Color = bg } },
		{ Foreground = { Color = fg } },
		{ Text = " " .. wezterm.hostname() .. " " .. wezterm.strftime("%a %b %-d %H:%M") .. " " },
	}))
end)

return config
