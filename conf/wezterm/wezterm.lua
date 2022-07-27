local wezterm = require 'wezterm'

return {
	front_end = "OpenGL",
	enable_wayland = false,

	font_dirs = {"/home/raven/.local/share/fonts"},
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

	window_padding = {
		left = '32pt',
		right = '32pt',
		top = '32pt',
		bottom = '32pt'
	},

	colors = {
		foreground = '#C5C8C6',
		background = '#101419',

		cursor_bg = '#C5C8C6',
        	cursor_border = '#C5C8C6',

        	selection_fg = '#101419',
        	selection_bg = '#C5C8C6',

        	ansi = {
               		'#323949',
                	'#E6676B',
                	'#A2E4B8',
                	'#e2d06a',
               		'#92bbed',
                	'#ecc6e8',
                	'#80ffff',
                	'#cfebec',
        	},

        	brights = {
                	'#3d3e51',
               		'#FF7377',
                	'#AAF0C1',
                	'#eadd94',
                	'#bdd6f4',
                	'#f9ecf7',
                	'#b3ffff',
                	'#edf7f8',
        	},
}

	--[[colors = {
		foreground = '#C5C8C6',
		background = '#101419',
		selection_fg = '#101419',
		selection_bg = '#C5C8C6',
		split = '#444444',

		cursor_bg = '#C5C8C6',

		ansi = {
			'#242931',
			'#e05f65',
			'#78dba9',
			'#f1cf8a',
			'#70a5eb',
			'#c68aee',
			'#74bee9',
			'#dee1e6',
		},

		brights = {
			'#384148',
			'#fc7b81',
			'#94f7c5',
			'#ffeba6',
			'#8cc1ff',
			'#e2a6ff',
			'#90daff',
			'#fafdff'
		},
	}--]]
}
