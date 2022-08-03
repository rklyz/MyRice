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
		foreground = '#18181A',
		background = '#F2F2E9',

		cursor_bg = '#111317',
        	cursor_border = '#111317',

        	selection_fg = '#101419',
        	selection_bg = '#C5C8C6',

        	ansi = {
               		'#E1E4E6',
                	'#E68A8A',
                	'#C6E687',
                	'#E6B88A',
               		'#8AA8E6',
                	'#C78AE6',
                	'#8AC7E6',
                	'#323333',
        	},

        	brights = {
                	'#E1E4E6',
                        '#E68A8A',
                        '#C6E687',
                        '#E6B88A',
                        '#8AA8E6',
                        '#C78AE6',
                        '#8AC7E6',
                        '#323333',
        	},
	}
}
