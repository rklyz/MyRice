local awful = require "awful"
local gears = require "gears"
local wibox = require "wibox"
local beautiful = require "beautiful"
local dpi = beautiful.xresources.apply_dpi

local rubato = require "lib.rubato"

----- Var -----

width = dpi(350)
height = dpi(800)
gaps = dpi(25)

----- Widgets -----

-- Wrap Function (Center Function)

local wrap = function(widget)
	local w = {
		nil,
		{
			nil,
			widget,
			nil,
			layout = wibox.layout.align.vertical,
		},
		nil,
		layout = wibox.layout.align.horizontal,
	}

	return w
end

-- Padding/ Spacing function

local vertical_pad = function(size)
	return wibox.widget {
		forced_height = dpi(size),
		layout = wibox.layout.fixed.horizontal,
	}
end

-- User's Profile

local pfp = wibox.widget {
	{
		forced_width = dpi(160),
        	forced_height = dpi(160),
		downscale = true,
		halign = 'center',
		valign = 'center',
		image = beautiful.pfp,
		widget = wibox.widget.imagebox,
	},
	shape = gears.shape.circle,
	bg = beautiful.bar,
	widget = wibox.container.background,
}

-- User's name

local user = wibox.widget {
	{
		markup = beautiful.user,
		font = beautiful.font_name .. " 28",
		align = 'center',
		widget = wibox.widget.textbox,
	},
	margins = {top = dpi(20)},
	widget = wibox.container.margin,
}

-- Hostname

local hostname = wibox.widget {
	markup = "<span foreground='" .. beautiful.taglist_fg_empty .. "'>" .. beautiful.hostname .. "</span>",
	font = beautiful.font_name .. " italic 14",
	align = 'center',
	widget = wibox.widget.textbox,
}

-- Put user info all together

local profile = wibox.widget {
	{
		pfp,
		user,
		hostname,
		layout = wibox.layout.fixed.vertical,
	},
	bg = beautiful.bar,
	widget = wibox.container.background,
}

-- Date

local date = wibox.widget {
	markup = "",
	align = 'center',
	font = "Roboto Mono Medium" .. " 18",
	widget = wibox.widget.textbox,
}

-- Day

local day = wibox.widget {
	markup = "",
	align = 'center',
	font = "Roboto Mono Medium" .. " 18",
	widget = wibox.widget.textbox,
}

-- Function for updating da clock

local update_clock = function(widget, widget2)
	_ = os.date("%B %d")
	__ = os.date("%A")
	widget.markup = _
	widget2.markup = __
end

-- Clock Timer

local timer_clock = gears.timer {
	timeout = 5,
	autostart = true,
	call_now = true,
	callback = function()
		update_clock(date, day)
	end,
}

-- CLock itself

local clock = wibox.widget {
	{
		{
			nil,
			{
				day,
				date,
				spacing = dpi(8),
				layout = wibox.layout.fixed.horizontal,
			},
			expand = 'none',
			layout = wibox.layout.align.horizontal,
		},
		margins = dpi(5),
		widget = wibox.container.margin,
	},
	shape = function(cr,w,h) gears.shape.rounded_rect(cr,w,h,5) end,
	bg = beautiful.bar,
	widget = wibox.container.background,
}

-- Bar/progresssbar Function

local make_bar = function(color, shape)
	local bar = wibox.widget {
		forced_width = dpi(200),
		forced_height = dpi(20),
		shape = shape,
                bar_shape = shape,
                color = color,
                background_color = beautiful.bar_alt,
       	        max_value = 100,
                min_value = 0,
                value = 20,
                widget = wibox.widget.progressbar,
	}

	return bar
end

local make_icon = function(icon, color, size)
	local icon = wibox.widget {
		markup = "<span foreground='" .. color .. "'>" .. icon .. "</span>",
		font = beautiful.font_name .. " " .. size,
		align = 'center',
		valign = 'center',
		widget = wibox.widget.textbox,
	}

	return icon
end

-- Slider Function (I know I'm lazy)
-- Bar Function -> Slider Function

local add_slider = function(bar, icon)

	-- The whole widget

	local w = wibox.widget {
		icon,
		{
			bar,
			margins = {top = dpi(12), bottom = dpi(12)},
			widget = wibox.container.margin,
		},
		spacing = dpi(10),
		layout = wibox.layout.fixed.horizontal,
	}

	return w
end

local add_bar = function(bar, icon)

	local slider = wibox.widget {
		bar,
                forced_width = dpi(100),
                forced_height = dpi(100),
                direction = "east",
                widget = wibox.container.rotate,
	}

	local w = wibox.widget {
		slider,
		icon,
		layout = wibox.layout.stack,
	}

	return w
end

-- Stats:
-- vol/bright/cpu

local volbar = make_bar(beautiful.blue, gears.shape.rounded_bar)
local brightbar = make_bar(beautiful.yellow, gears.shape.rounded_bar)
local rembar = make_bar(beautiful.magenta, gears.shape.rounded_bar)
local cpubar = make_bar(beautiful.red, gears.shape.rounded_bar)

local volicon = make_icon("", beautiful.blue, 20)
local brighticon = make_icon("", beautiful.yellow, 20)
local remicon = make_icon("󰍛", beautiful.magenta, 20)
local cpuicon = make_icon("󰘚", beautiful.red, 20)

local volume = add_slider(volbar, volicon)
local bright = add_slider(brightbar, brighticon)
local rem = add_slider(rembar, remicon)
local cpu = add_slider(cpubar, cpuicon)

local volslide = rubato.timed {
	intro = 0.05,
	duration = 0.2,
	rate = 60,
	subscribed = function(pos)
		volbar.value = pos
	end
}

local brightslide = rubato.timed {
        intro = 0.05,
        duration = 0.2,
	rate = 60,
        subscribed = function(pos)
                brightbar.value = pos
        end
}

-- Connect-to-signals's Station ;)

awesome.connect_signal("signal::volume", function(vol, mute)
	if mute or vol == 0 then
		volslide.target = 0
	else
		volslide.target = vol or 0
	end
end)

awesome.connect_signal("signal::brightness", function(brightness)
	brightbar.max_value = 60
	brightslide.target = brightness
end)

awesome.connect_signal("signal::rem", function(value)
	rembar.value = value
end)

awesome.connect_signal("signal::cpu", function(value)
        cpubar.value = value
end)

-- Slider Behavior

volume:buttons(gears.table.join(
	awful.button({ }, 4, function()
		awful.spawn.with_shell("pamixer -i 2")
	end),
	awful.button({ }, 5, function()
		awful.spawn.with_shell("pamixer -d 2")
	end)
))

bright:buttons(gears.table.join(
        awful.button({ }, 4, function()
                awful.spawn.with_shell("brightnessctl set +1%")
        end),
        awful.button({ }, 5, function()
                awful.spawn.with_shell("brightnessctl set 2%-")
        end)
))

local stats = wibox.widget {
	{
		{
			nil,
			{
				volume,
				bright,
				rem,
				cpu,
				spacing = dpi(5),
				layout = wibox.layout.fixed.vertical,
			},
			expand = "none",
			layout = wibox.layout.align.horizontal,
		},
		margins = dpi(0),
		widget = wibox.container.margin,
	},
	border_width = dpi(4),
	border_color = beautiful.bar,
	shape = function(cr,w,h) gears.shape.rounded_rect(cr,w,h,5) end,
	bg = beautiful.bar,
	widget = wibox.container.background,
}

-- Playerctl / Music / Spotify

local art_p = wibox.widget {
	{
		id = "art",
		resize = true,
		halign = "center",
		valign = "center",
		downscale = true,
		shape = gears.shape.squircle,
		widget = wibox.widget.imagebox,
	},
	border_width = dpi(2),
	border_color = beautiful.bar_alt,
	forced_width = dpi(120),
	forced_height = dpi(120),
	shape = gears.shape.squircle,
	widget = wibox.container.background,
}

local title_p = wibox.widget {
	forced_height = dpi(50),
	markup = "Not Playing",
	font = beautiful.font_name .. " 14",
	align = "center",
	valign = "center",
	widget = wibox.widget.textbox,
}

local add_button = function(text, size, command)
	local button = wibox.widget {
		markup = "<span foreground='" .. beautiful.blue .. "'>" .. text .. "</span>",
		font = beautiful.font_name .. " " .. size,
		widget = wibox.widget.textbox,
	}

	button:buttons(gears.table.join(
		awful.button({ }, 1, function()
			command()
		end)
	))

	return button
end

local playerctl = require "lib.bling".signal.playerctl.lib {
	ignore = "firefox"
}
local toggle_p = function()
	playerctl:play_pause()
end

local next_p = function()
	playerctl:next()
end

local prev_p = function()
	playerctl:previous()
end

playerctl:connect_signal("metadata", function(_, title, artist, album_path, album, new, player_name)
	title_p:set_markup_silently(title)
	art_p.art:set_image(gears.surface.load_uncached(album_path))
end)

local togglebutton = wibox.widget {
        markup = "<span foreground='" .. beautiful.blue .. "'></span>",
        font = beautiful.font_name .. " 22",
        widget = wibox.widget.textbox,
}

togglebutton:buttons(gears.table.join(
        awful.button({}, 1, function()
                playerctl:play_pause()
        end)
))

local nextbutton = add_button("", "22", next_p)
local prevbutton = add_button("", "22", prev_p)

playerctl:connect_signal("playback_status", function(_, playing, __)
	if playing then
		togglebutton.markup = "<span foreground='" .. beautiful.blue .. "'></span>"
	else
		togglebutton.markup = "<span foreground='" .. beautiful.blue .. "'></span>"
	end
end)

local music = wibox.widget {
	{
		{
			nil,
			{
				art_p,
				{
					{
						title_p,
						widget = wibox.container.margin,
					},
					{
						nil,
						{
							prevbutton,
							togglebutton,
							nextbutton,
							spacing = dpi(25),
							layout = wibox.layout.fixed.horizontal,
						},
						expand = "none",
						layout = wibox.layout.align.horizontal,
					},
					spacing = dpi(10),
					layout = wibox.layout.align.vertical,
				},
				spacing = dpi(20),
				layout = wibox.layout.fixed.horizontal,
			},
			expand = "none",
			layout = wibox.layout.align.horizontal,
		},
		widget = wibox.container.margin,
	},
	bg = beautiful.bar,
	widget = wibox.container.background,
}

-- Weather

local temp_w = wibox.widget {
	font = beautiful.font_name .. " 16",
	align = "left",
	widget = wibox.widget.textbox,
}

local icon_w = wibox.widget {
	font = beautiful.font_name .. " 34",
	align = "center",
	widget = wibox.widget.textbox,
}

local desc_w = wibox.widget {
	font = beautiful.font,
	align = "center",
	widget = wibox.widget.textbox,
}

awesome.connect_signal("signal::weather", function(temp, icon, how)
	icon_w.markup = tostring(icon)
	temp_w.markup = tostring(temp) .. "󰔄"
	desc_w.markup = tostring(how)
end)

local weather = wibox.widget {
	{
		nil,
		{
			icon_w,
			{
				nil,
				{
					temp_w,
					desc_w,
					layout = wibox.layout.fixed.vertical,
				},
				expand = "none",
				layout = wibox.layout.align.vertical,
			},
			spacing = dpi(10),
			layout = wibox.layout.fixed.horizontal,
		},
		expand = 'none',
		layout = wibox.layout.align.horizontal,
	},
	bg = beautiful.bar,
	widget = wibox.container.background,
}


local sidebar = awful.popup {
	ontop = true,
	visible = false,
	placement = function(c)
		awful.placement.right(c)
	end,
	shape = function(cr,w,h) gears.shape.partially_rounded_rect(cr,w,h,true,false,false,false,25) end,
	widget = wibox.container.margin,
}

sidebar:setup {
	{
		{
			profile,
			{
				nil,
				{
					vertical_pad(gaps * 2),
					weather,
					vertical_pad(gaps * 2),
					stats,
					vertical_pad(gaps * 2),
					music,
					layout = wibox.layout.fixed.vertical,
				},
				expand = 'none',
				layout = wibox.layout.align.vertical,
			},
			layout = wibox.layout.align.vertical,
		},
		margins = gaps,
		widget = wibox.container.margin,
	},
	forced_width = width,
	forced_height = height,
	bg = beautiful.bar,
	widget = wibox.container.background,
}

local slide = rubato.timed {
	pos = awful.screen.focused().geometry.width,
	rate = 60,
	intro = 0.1,
	duration = 0.33,
	subscribed = function(pos) sidebar.x = awful.screen.focused().geometry.x + pos end
}

local slide_end = gears.timer({
        single_shot = true,
        timeout = 0.33 + 0.08,
        callback = function()
        	sidebar.visible = false
        end,
})

local toggle = function()
	if sidebar.visible then
		slide_end:again()
		slide.target = awful.screen.focused().geometry.width
	else
		sidebar.visible = true
		slide.target = awful.screen.focused().geometry.width - sidebar.width
	end
end

awesome.connect_signal("sidebar::toggle", function()
	toggle()
end)
