local awful = require "awful"
local gears = require "gears"
local wibox = require "wibox"
local naughty = require "naughty"
local beautiful = require "beautiful"

local dpi = beautiful.xresources.apply_dpi
local supporter = require "supporter"
local apply_borders = require "lib.borders"

----- Powermenu -----

local poweroff = supporter.create_button("󰐥", "Roboto Medium 20", beautiful.red, beautiful.red.."dd", function() awful.spawn("poweroff", false) end)
local reboot = supporter.create_button("󰜉", "Roboto Medium 20", beautiful.yellow, beautiful.yellow.."dd", function() awful.spawn("reboot", false) end)
local sleep = supporter.create_button("󰤄", "Roboto Medium 20", beautiful.blue, beautiful.blue.."dd", function() awful.spawn("systemctl suspend", false) end)

local container = wibox.widget.background()
container.bg = beautiful.bar

return function(width, height)

	return apply_borders(wibox.widget {
		{
			nil,
			{
				nil,
				{
					poweroff,
					reboot,
					sleep,
					spacing = dpi(10),
					layout = wibox.layout.fixed.vertical,
				},
				expand = 'none',
				layout = wibox.layout.align.vertical,
			},
			expand = 'none',
			layout = wibox.layout.align.horizontal,
		},
		widget = container,
	}, width, height, 18)
end
