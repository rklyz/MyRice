local awful = require "awful"
local wibox = require "wibox"
local gears = require "gears"
local beautiful = require "beautiful"
local dpi = beautiful.xresources.apply_dpi

-- Icon
local icon = wibox.widget.textbox()
icon.font = "Roboto Medium 24"
icon.align = 'center'

-- Wifi Name
local wifi = wibox.widget.textbox()
wifi.font = "Roboto Medium 16"
wifi.align = 'center'
wifi.markup = "Connecting.." -- In case it's still fetching wifi name

awesome.connect_signal("signal::wifi", function(connected, ssid) 
	if connected then 
		ssid = tostring(ssid)
		ssid = ssid:match("(.-)[:]")
		icon.markup = "<span foreground='"..beautiful.green.."'>󰤨</span>"
		wifi.markup = ssid
	else
		icon.markup = "<span foreground='"..beautiful.red.."'>󰤭</span>"
		wifi.markup = "Not Connected ;-;"
	end
end)

return wibox.widget {
	icon,
	wifi,
	spacing = dpi(10),
	layout = wibox.layout.fixed.horizontal
}
