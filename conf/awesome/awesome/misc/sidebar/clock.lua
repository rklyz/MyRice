local awful = require "awful"
local wibox = require "wibox"
local gears = require "gears"
local beautiful = require "beautiful"

local dpi = beautiful.xresources.apply_dpi

-- Day
local day = wibox.widget.textbox()
day.font = "Roboto bold 32"
day.align = 'center'

local date = wibox.widget.textbox()
date.font = "Roboto bold 14"
date.align = 'center'

gears.timer {
	timeout = 60,
	call_now = true,
	autostart = true,
	callback = function()
		day.markup = "<span foreground='"..beautiful.red.."'>"..os.date("%A").."</span>"
		date.markup = os.date("%d %B %Y")
	end
}

return wibox.widget {
	day,
	date,
	spacing = dpi(4),
	layout = wibox.layout.fixed.vertical,
}
