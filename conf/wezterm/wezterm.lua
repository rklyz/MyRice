local wezterm = require 'wezterm'

return {
	front_end = "OpenGL",
	enable_wayland = false,

	font_dirs = {"/home/neko/.local/share/fonts"},
	font = wezterm.font('Roboto Mono', {weight = 'Regular'}),
	font_size = 13.0,
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
		foreground = '#33374c',
		background = '#e8e9ec',

		cursor_bg = '#33374c',
        	cursor_border = '#33374c',

        	selection_fg = '#101419',
        	selection_bg = '#C5C8C6',

        	ansi = {
               		'#dcdfe7',
                	'#cc517a',
                	'#668e3d',
                	'#c57339',
               		'#2d539e',
                	'#7759b4',
                	'#3f83a6',
                	'#33374c',
        	},

        	brights = {
                	'#8389a3',
               		'#cc3768',
                	'#598030',
                	'#b6662d',
                	'#22478e',
                	'#6845ad',
                	'#327698',
                	'#262a3f',
        	},
	}
}
