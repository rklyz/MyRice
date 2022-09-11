local wezterm = require 'wezterm'

local light = require 'light'
local dark = require 'dark'

local theme = dark

return {
	front_end = "OpenGL",
	enable_wayland = false,

	font_dirs = {"/home/neko/.local/share/fonts"},
	font = wezterm.font('Roboto Mono', {weight = 'Regular'}),
	font_size = 14.0,
	harfbuzz_features = {"calt=0", "clig=0", "liga=0"},

	enable_tab_bar = false,
	hide_tab_bar_if_only_one_tab = true,
	show_tab_index_in_tab_bar = false,

	default_cursor_style = 'BlinkingUnderline',
	cursor_blink_rate = 600,
	animation_fps = 1,
	cursor_blink_ease_in = 'Constant',
	cursor_blink_ease_out = 'Constant',

	visual_bell = {
		fade_in_duration_ms = 75,
		fade_out_duration_ms = 75,
		target = 'CursorColor',
	},

	window_padding = {
		left = '32pt',
		right = '32pt',
		top = '32pt',
		bottom = '32pt'
	},

	colors = {
		foreground = theme.foreground,
		background = theme.background,

		cursor_bg = theme.cursor_bg,
    cursor_border = theme.cursor_border,

		selection_fg = theme.selection_fg,
		selection_bg = theme.selection_bg,

		ansi = {
			theme.ansi[1],
			theme.ansi[2],
			theme.ansi[3],
			theme.ansi[4],
			theme.ansi[5],
			theme.ansi[6],
      theme.ansi[7],
      theme.ansi[8],
    },

    brights = {
			theme.brights[1],
      theme.brights[2],
      theme.brights[3],
      theme.brights[4],
      theme.brights[5],
      theme.brights[6],
      theme.brights[7],
      theme.brights[8],
    },
	}
}
