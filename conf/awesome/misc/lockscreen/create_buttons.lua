local awful = require "awful"
local gears = require "gears"
local wibox = require "wibox"
local beautiful = require "beautiful"

-- Create function
local create_button = function(icon, text, bgcolor, cmd)
	local button = wibox.widget {
		{
			id = "button",
			markup = icon,
			align = 'center',
			valign = 'center',
			font = "Roboto Medium 54",
			widget = wibox.widget.textbox,
		},
		bg = bgcolor,
		shape = function(cr,w,h) gears.shape.rounded_rect(cr,w,h) end,
		forced_width = 84,
		forced_height = 84,
		widget = wibox.container.background,
	}

	button:buttons(gears.table.join(
		awful.button({ }, 1, function() awful.spawn(cmd, false) end)
	))

	return button
end

return create_button
