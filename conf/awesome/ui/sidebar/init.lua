local awful = require "awful"
local gears = require "gears"
local wibox = require "wibox"
local beautiful = require "beautiful"
local naughty = require "naughty"
local dpi = beautiful.xresources.apply_dpi

local rubato = require "lib.rubato"

----- Var -----
scr = awful.screen.focused()

border = dpi(2)
width = dpi(320) - border -- To get desired width without border
height = dpi(400) - border -- Same as width ^^^
gaps = dpi(20)

----- Function -----
local rr = function(cr,w,h)
	gears.shape.rounded_rect(cr,w,h,5)
end

local partial_rr = function(cr,w,h)
	gears.shape.partially_rounded_rect(cr,w,h,false,true,false,false,32)
end

local pad_h = function(pad)
	return wibox.widget {
		forced_width = pad,
		widget = wibox.container.background,
	}
end

local pad_v = function(pad)
	return wibox.widget {
		forced_height = pad,
		widget = wibox.container.background,
	}
end

local coloring_text = function(text, color)
	color = color or beautiful.fg_normal
	return "<span foreground='" .. color .. "'>" .. text .. "</span>"
end

local crt_box = function(widget, bg_color, border_width)
	local container = wibox.container.background()
	--container.forced_width = width
	--container.forced_height = height
	container.border_width = border_width or 0
	container.border_color = beautiful.bar_alt
	container.bg = bg_color or beautiful.transparent
	container.shape = rr

	local box_widget = wibox.widget {
		{
			{
				nil,
				{
					nil,
					widget,
					expand = 'none',
					layout = wibox.layout.align.vertical,
				},
				expand = 'none',
				layout = wibox.layout.align.horizontal,
			},
			widget = container,
		},
		margins = dpi(10),
		widget = wibox.container.margin,
	}

	return box_widget
end

----- Widgets -----

sidebar = wibox {
	visible = true,
	ontop = true,
	width = width,
	height = height,
	border_width = border,
	border_color = beautiful.bar_alt,
	bg = beautiful.bar,
	shape = rr,
	type = 'dock'
}

awful.placement.top_left(sidebar, { margins = {top = dpi(90)}})

--sidebar:struts {left = dpi(40 + sidebar.width)}

local slide = rubato.timed {
	pos = scr.geometry.x - sidebar.width,
	rate = 60,
	intro = 0.2,
	duration = 0.4,
	subscribed = function(pos)
		sidebar.x = scr.geometry.x + gaps + pos
	end
}

local timer = gears.timer {
	timeout = 0.4,
	call_now = true,
	single_shot = true,
	callback = function()
		sidebar.visible = not sidebar.visible
	end
}

local toggle = function()
	if sidebar.visible then
		slide.target = scr.geometry.x - sidebar.width -- x = 0 - sidebar's width
		timer:start()
	else
		slide.target = scr.geometry.x -- x = 0
		sidebar.visible = not sidebar.visible
	end
end

awesome.connect_signal("sidebar::toggle", function()
	toggle()
end)

----- Var -----

-- Clock
local hour = wibox.widget.textbox()
local minute = wibox.widget.textbox()
local ampm = wibox.widget.textbox()
hour.font = beautiful.font_name .. " bold 42"
hour.align = 'center'
minute.font = beautiful.font_name .. " bold 42"
minute.align = 'center'
ampm.font = beautiful.font_name .. " bold 12"
ampm.align = 'left'
ampm.valign = 'top'

local date = wibox.widget.textbox()
date.font = beautiful.font_name .. " Medium 14"
date.align = 'center'

local time = wibox.widget {
	hour,
	pad_h(20),
	minute,
	ampm,
	layout = wibox.layout.fixed.horizontal,
}

gears.timer {
	timeout = 60,
	call_now = true,
	autostart = true,
	callback = function()
		hour.markup = coloring_text(os.date('%I'), beautiful.magenta)
		minute.markup = coloring_text(os.date('%M'), beautiful.magenta)
		date.markup = coloring_text(os.date('%A %b %d'), beautiful.fg_normal)
		local night = {}
		if os.date('%p') == "PM"  then
			night.color = beautiful.fg_normal
		else
			night.color = beautiful.yellow
		end
		ampm.markup = coloring_text(os.date('%p'), night.color)
	end
}

local clock_widget = wibox.widget {
	{
		time,
		date,
		layout = wibox.layout.fixed.vertical,
	},
	margins = { left = dpi(12), right = dpi(12), top = dpi(10), bottom = dpi(10) },
	widget = wibox.container.margin,
}

local clock = crt_box(clock_widget, beautiful.transparent)

-- Separatorr
local separator_widget = wibox.widget {
	forced_height = dpi(5),
	bg = beautiful.bar_alt,
	widget = wibox.container.background,
}

local separator = wibox.widget {
	separator_widget,
	margins = {bottom = dpi(20)},
	widget = wibox.container.margin,
}

-- Todo:
--    | Volume/Brightness
--    | Notifications center

-- Uptime
local uptime_widget = wibox.widget.textbox()
uptime_widget.font = beautiful.font_name .. " Medium 14"
uptime_widget.align = 'center'

local get_uptime = function()
	awful.spawn.easy_async_with_shell('uptime -p', function(stdout)
		uptime_widget.markup = coloring_text(stdout)
	end)
end

gears.timer {
	timeout = 60,
	autostart = true,
	call_now = true,
	callback = function()
		get_uptime()
	end
}

-- Volume/Brightness
local icon = {
	["volume"] = {icon = "󰋋", color = beautiful.blue},
	["bright"] = {icon = "󰃟", color = beautiful.yellow},
}

local crt_icon = function(text, color)
	local icon_widget = wibox.widget.textbox()
	icon_widget.font = beautiful.font_name .. " 22"
	icon_widget.align = 'center'
	icon_widget.markup = coloring_text(text, color)

	return icon_widget
end

local volume_icon = crt_icon(icon["volume"].icon, icon["volume"].color)
local bright_icon = crt_icon(icon["bright"].icon, icon["bright"].color)

local crt_slider = function(color)
	local slider_widget = wibox.widget.slider()
	slider_widget.forced_width = dpi(160)
	slider_widget.forced_height = dpi(38)
	slider_widget.bar_shape = gears.shape.rounded_rect
	slider_widget.bar_height = dpi(5)
	slider_widget.bar_color = beautiful.bar2
	slider_widget.bar_active_color = color
	slider_widget.handle_color = color
	slider_widget.handle_shape = gears.shape.circle

	return slider_widget
end

local volume_slider = crt_slider(beautiful.blue)
local bright_slider = crt_slider(beautiful.yellow)

local search_vol = true

local get_volume = function()
	awful.spawn.easy_async_with_shell("pamixer --get-volume", function(stdout)
      		local value = string.gsub(stdout, "^%s*(.-)%s*$", "%1")
       		volume_slider.value = tonumber(value)
	end)
end

local get_brightness = function()
	awful.spawn.easy_async_with_shell("brightnessctl g", function(stdout)
        	local bri = tonumber(stdout)
		awful.spawn.easy_async_with_shell("brightnessctl m", function(stdout)
                	local max = tonumber(stdout)
                	local value = bri/max * 100
                	bright_slider.value = value
        	end)
	end)
end

gears.timer {
	timeout = 2,
	autostart = true,
	call_now = true,
	callback = function()
		get_volume()
		get_brightness()
	end
}

volume_slider:connect_signal("property::value", function(_, new_value)
        volume_slider.value = new_value
        awful.spawn("pamixer --set-volume " .. new_value, false)
end)

bright_slider:connect_signal('property::value', function(_, value)
	bright_slider.value = value
	awful.spawn.with_shell('brightnessctl set ' .. value .. '%')
end)

local volume_widget = wibox.layout.fixed.horizontal()
volume_widget.spacing = dpi(12)
volume_widget:add(volume_icon, volume_slider)

local bright_widget = wibox.layout.fixed.horizontal()
bright_widget.spacing = dpi(12)
bright_widget:add(bright_icon, bright_slider)

-- Buttons
local manybutton = wibox.widget {
	nil,
	{
		nil,
		{
			require "ui.sidebar.wifi", -- Return wifi
			require "ui.sidebar.bluetooth",
			require "ui.sidebar.sunlight",
			spacing = dpi(14),
			layout = wibox.layout.fixed.horizontal,
		},
		expand = 'none',
		layout = wibox.layout.align.horizontal,
	},
	expand = 'none',
	layout = wibox.layout.align.vertical,
}

local buttons = crt_box(manybutton, beautiful.bar)


sidebar : setup {
	{
		nil,
		{
			clock,
			separator,
			uptime_widget,
			volume_widget,
			bright_widget,
			buttons,
			layout = wibox.layout.fixed.vertical,
		},
		expand = 'none',
		layout = wibox.layout.align.horizontal,
	},
	bg = beautiful.bar,
	widget = wibox.container.background,
}

