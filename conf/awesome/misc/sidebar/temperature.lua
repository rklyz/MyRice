local awful = require "awful"
local wibox = require "wibox"
local gears = require "gears"
local beautiful = require "beautiful"
local dpi = beautiful.xresources.apply_dpi

-- Icon
local icon = wibox.widget.textbox()
icon.font = "Roboto Medium 24"
icon.align = 'center'
icon.markup = "<span foreground='"..beautiful.red.."'>󰔏</span>"

-- Feels like
local feels_like = wibox.widget.textbox()
feels_like.font = "Roboto Medium 16"
feels_like.align = 'center'

awesome.connect_signal("signal::weather", function(_, temp) 
	temp = tostring(temp)
	temp = string.gsub(temp, "\n", "") -- Remove new line
	temp = string.gsub(temp, "'", "") -- Remove "'"
	feels_like.markup = temp
end)

return wibox.widget {
	icon,
	feels_like,
	spacing = dpi(10),
	layout = wibox.layout.fixed.horizontal,
}
