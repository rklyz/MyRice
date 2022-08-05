local awful = require "awful"
local wibox = require "wibox"
local gears = require "gears"
local beautiful = require "beautiful"
local dpi = beautiful.xresources.apply_dpi

-- Icon
local icon = wibox.widget.textbox()
icon.font = "Roboto Bold 24"
icon.align = 'center'
icon.markup = "<span foreground='"..beautiful.blue.."'>󰖐</span>"

-- How's weather?
local hows_weather = wibox.widget.textbox()
hows_weather.font = "Roboto Medium 16"
hows_weather.align = 'center'

awesome.connect_signal("signal::weather", function(weather, _)
	weather = tostring(weather)
	weather = string.gsub(weather, "'", "")
	hows_weather.markup = weather
end)

return wibox.widget {
	icon,
	hows_weather,
	spacing = dpi(10),
	layout = wibox.layout.fixed.horizontal,
}
