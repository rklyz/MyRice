local awful = require "awful"
local gears = require "gears"
local wibox = require "wibox"
local beautiful = require "beautiful"
local naughty = require "naughty"
local dpi = beautiful.xresources.apply_dpi

local rubato = require "lib.rubato"

local supporter = require "supporter"

----- requirement -----

----- Var -----
scr = awful.screen.focused()

border = dpi(0)
width = dpi(420) - border -- To get desired width without border
height = scr.geometry.height - border -- Same as width ^^^
gaps = dpi(0)

----- Widgets -----

local sidebar = wibox {
	visible = true,
	ontop = true,
	width = width,
	height = height,
	bg = beautiful.bar,
	type = 'dock'
}

awful.placement.top_left(sidebar)

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
--- Time
local day = wibox.widget.textbox()
day.font = beautiful.font_name .. " bold 32"
day.align = 'center'

local date = wibox.widget.textbox()
date.font = beautiful.font_name .. " bold 14"
date.align = 'center'

local update_time = function()
	day.markup = supporter.text_coloring(os.date("%A"), beautiful.red)
	date.markup = os.date("%d %B %Y")
end

local time_widget = wibox.widget {
	day,
	date,
	spacing = dpi(4),
	layout = wibox.layout.fixed.vertical,
}

gears.timer {
	timeout = 60,
	call_now = true,
	autostart = true,
	callback = function()
		update_time()
	end
}

local time = supporter.create_box(time_widget, dpi(0), dpi(40))

--- User Profile
local pfp = wibox.widget.imagebox()
pfp.image = beautiful.pfp
pfp.clip_shape = gears.shape.circle
pfp.forced_width = dpi(300)
pfp.forced_height = dpi(300)

local user = wibox.widget.textbox()
user.font = beautiful.font_name .. " bold 32"
user.align = 'center'
user.markup = supporter.text_coloring(string.gsub(os.getenv("USER"), "^%l", string.upper), beautiful.red) -- Capitalize first letter in 1 line hehe

local hostname = wibox.widget.textbox()
hostname.font = beautiful.font_name .. " bold 14"
hostname.align = 'center'

awful.spawn.easy_async_with_shell("echo $HOST", function(stdout)
	hostname.markup = "@" .. tostring(stdout)
end)

local profile_widget = wibox.widget {
	{
		nil,
		pfp,
		expand = 'none',
		layout = wibox.layout.align.horizontal,
	},
	supporter.spacing_v(dpi(6)),
	user,
	hostname,
	layout = wibox.layout.fixed.vertical,
}

local profile = supporter.create_box(profile_widget, dpi(10), dpi(10))

--- Weather
local hows_weather = wibox.widget.textbox()
hows_weather.font = beautiful.font_name .. " Medium 20"
hows_weather.align = 'center'
hows_weather.markup = "Fetching.." -- Use this first while fetching data

local weather_icon = wibox.widget.textbox()
weather_icon.font = beautiful.font_name .. " bold 24"
weather_icon.align = 'center'
weather_icon.markup = supporter.text_coloring("󰖐", beautiful.blue)

awesome.connect_signal("signal::weather", function(status, _)
	status = string.gsub(status, "'", "")
	status = string.gsub(status, "\n", "")
	hows_weather.markup = status
end)

local weather_widget = wibox.widget {
	supporter.spacing_h(dpi(20)),
	weather_icon,
	hows_weather,
	spacing = dpi(10),
	layout = wibox.layout.fixed.horizontal,
}

local weather = supporter.create_box(weather_widget, dpi(30), dpi(20))

-- Temperature
local celsius = wibox.widget.textbox()
celsius.font = beautiful.font_name .. " Medium 20"
celsius.align = 'center'

local temp_icon = wibox.widget.textbox()
temp_icon.font = beautiful.font_name .. " Medium 24"
temp_icon.align = 'center'
temp_icon.markup = supporter.text_coloring("󰔏", beautiful.red)

awesome.connect_signal("signal::weather", function(_, feels_like)
	feels_like = string.gsub(feels_like, "'", "")
	feels_like = string.gsub(feels_like, "\n", "")
	celsius.markup = feels_like
end)

local temp_widget = wibox.widget {
	supporter.spacing_h(dpi(20)),
	temp_icon,
	celsius,
	spacing = dpi(10),
	layout = wibox.layout.fixed.horizontal,
}

local temperature = supporter.create_box(temp_widget, dpi(20), dpi(20))

--- Wifi
local wifi_name = wibox.widget.textbox()
wifi_name.font = beautiful.font_name .. " Medium 20"
wifi_name.align = 'center'

local wifi_icon = wibox.widget.textbox()
wifi_icon.font = beautiful.font_name .. " bold 24"
wifi_icon.align = 'center'

local wifi_widget = wibox.widget {
	supporter.spacing_h(dpi(20)),
	wifi_icon,
	wifi_name,
	spacing = dpi(10),
	layout = wibox.layout.fixed.horizontal,
}

awesome.connect_signal("signal::wifi", function(net_stat, net_ssid)
	if net_stat then
		net_ssid = net_ssid:match("(.-):")
		wifi_name.markup = net_ssid
		wifi_icon.markup = supporter.text_coloring("󰤨", beautiful.green)
	else
		wifi_name.markup = "No Connection ;-;"
		wifi_icon.markup = supporter.text_coloring("󰤯", beautiful.red)
	end
end)

local wifi = supporter.create_box(wifi_widget, dpi(20), dpi(20))

--- Uptime
local uptime_icon = wibox.widget.textbox()
uptime_icon.font = beautiful.font_name .. " bold 24"
uptime_icon.align = 'center'
uptime_icon.markup = supporter.text_coloring("󰍹", beautiful.yellow)

local the_uptime = wibox.widget.textbox()
the_uptime.font = beautiful.font_name .. " Medium 20"
the_uptime.align = 'center'

local update_uptime = function()
	local script = [[
	uptime -p]]

	awful.spawn.easy_async_with_shell(script, function(stdout)
		stdout = string.gsub(stdout, "\n", "")
		stdout = string.gsub(stdout, "^%l", string.upper)
		the_uptime.markup = tostring(stdout)
	end)
end

gears.timer {
	timeout = 60,
	call_now = true,
	autostart = true,
	callback = function()
		update_uptime()
	end
}

local uptime_widget = wibox.widget {
	supporter.spacing_h(dpi(20)),
	uptime_icon,
	the_uptime,
	spacing = dpi(10),
	layout = wibox.layout.fixed.horizontal,
}

local uptime = supporter.create_box(uptime_widget, dpi(20), dpi(20))

--- Info
local info = wibox.widget {
	nil,
	{
		weather,
		temperature,
		wifi,
		uptime,
		layout = wibox.layout.fixed.vertical,
	},
	expand = 'none',
	layout = wibox.layout.align.horizontal,
}

local side_widget = wibox.widget {
	{
		time,
		profile,
		info,
		layout = wibox.layout.fixed.vertical,
	},
	margins = dpi(10),
	widget = wibox.container.margin,
}

sidebar : setup {
	nil,
	side_widget,
	expand = 'none',
	layout = wibox.layout.align.vertical,
}

