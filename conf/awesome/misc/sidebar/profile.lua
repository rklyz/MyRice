local awful = require "awful"
local wibox = require "wibox"
local gears = require "gears"
local beautiful = require "beautiful"

local dpi = beautiful.xresources.apply_dpi

-- Helper
-----------

local function round_widget(radius)
	return function(cr,w,h)
		gears.shape.rounded_rect(cr,w,h,radius)
	end
end

-- Create Widgets
-------------------

-- Pfp
local pfp = wibox.widget.imagebox()
pfp.image = beautiful.pfp
pfp.clip_shape = gears.shape.circle
pfp.forced_width = dpi(130)
pfp.forced_height = dpi(130)

-- User
local user = wibox.widget.textbox()
user.font = "Roboto SemiBold 18"
user.align = 'left'
user.markup = "<span foreground='"..beautiful.fg.."'>"..beautiful.user.."</span>"

-- Hostname
local hostname = wibox.widget.textbox()
hostname.font = "Roboto Regular 14"
hostname.align = 'left'

awful.spawn.easy_async_with_shell("cat /proc/sys/kernel/hostname", function(stdout)
	hostname.markup = "@"..tostring(stdout)
end)

-- Weather Icon
local weather_icon = wibox.widget.imagebox()
weather_icon.image = beautiful.weather_icon
weather_icon.forced_width = dpi(70)
weather_icon.forced_height = dpi(47)

-- Temperature
local temperature = wibox.widget.textbox()
temperature.font = "Roboto Medium 20"
temperature.align = 'left'

-- How's the weather?
local the_weather = wibox.widget.textbox()
the_weather.font = "Roboto Medium 14"
the_weather.align = "left"

-- Battery
local bat_desc = wibox.widget.textbox()
bat_desc.font = "Roboto Medium 12"
bat_desc.align = "center"

local battery = wibox.widget {
	{
		id = "bat_val",
		forced_width = dpi(130),
		forced_height = dpi(22),
		background_color = "#4B6133",
		color = beautiful.green,
		shape = round_widget(12),
		bar_shape = round_widget(12),
		max_value = 100,
		widget = wibox.widget.progressbar,
	},
	{
		widget = bat_desc,
	},
	layout = wibox.layout.stack,
}

-- Get data 4 widgets!
awesome.connect_signal("signal::bat", function(bat_value, bat_preview)
	battery.bat_val.value = bat_value
	bat_desc.markup = "<span foreground='"..beautiful.black.."'>"..bat_preview.."</span>"
end)

awesome.connect_signal("signal::weather", function(hows_weather, feels_like)
	hows_weather = string.gsub(hows_weather, "'", "")
	feels_like = string.gsub(feels_like, "\n", "")
	the_weather.markup = hows_weather
	temperature.markup = feels_like:match("%d%d").."°C"
end)

-- Spacing horizontally
local space = wibox.widget {
	forced_height = dpi(6),
	layout = wibox.layout.align.horizontal
}

-- Grouping widgets
---------------------

local name = wibox.widget {
	user,
	hostname,
	spacing = dpi(4),
	layout = wibox.layout.fixed.vertical,
}

local weather = wibox.widget {
	{
		weather_icon,
		temperature,
		spacing = dpi(20),
		layout = wibox.layout.fixed.horizontal,
	},
	{
		widget = the_weather,
	},
	spacing = dpi(8),
	layout = wibox.layout.fixed.vertical,
}

-- The Profile Widget
return wibox.widget {
	{
		{
			pfp,
			battery,
			spacing = dpi(20),
			layout = wibox.layout.fixed.vertical,
		},
		layout = wibox.layout.fixed.vertical,
	},
	{
		name,
		weather,
		layout = wibox.layout.fixed.vertical,
	},
	spacing = dpi(30),
	layout = wibox.layout.fixed.horizontal,
}
