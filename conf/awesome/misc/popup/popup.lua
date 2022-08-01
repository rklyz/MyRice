local awful = require "awful"
local wibox = require "wibox"
local gears = require "gears"
local beautiful = require "beautiful"
local dpi = beautiful.xresources.apply_dpi

local create_popup = function(color)

	local slider = wibox.widget {
		color = color,
		background_color = beautiful.bg_alt,
		bar_shape = gears.shape.rounded_bar,
		shape = gears.shape.rounded_bar,
		max_value = 100,
		forced_width = dpi(150),
		forced_height = dpi(16),
		widget = wibox.widget.progressbar
	}

	local icon = wibox.widget.textbox()
	icon.font = "Roboto 82"
	icon.align = 'center'

	local widget = wibox.widget {
		nil,
		{
			{
				icon,
				{
					nil,
					slider,
					expand = 'none',
					layout = wibox.layout.align.horizontal,
				},
				spacing = dpi(10),
				layout = wibox.layout.fixed.vertical,
			},
			margins = dpi(10),
			widget = wibox.container.margin,
		},
		expand = 'none',
		layout = wibox.layout.align.vertical,
	}

	local popup = wibox {
		visible = true,
		ontop = true,
		width = dpi(200),
		height = dpi(200),
		x = awful.screen.focused().geometry.width / 2 - dpi(100),
		y = awful.screen.focused().geometry.height - dpi(200) - dpi(200),
		bg = beautiful.bg,
	}

	popup : setup {
		widget = widget,
	}

	popup.timer = gears.timer {
		timeout = 1,
		call_now = false,
		autostart = false,
		callback = function()
			popup.visible = false
		end
	}

	popup.toggle = function()
		popup.visible = true
		if popup.visible then
			popup.timer:again()
		else
			popup.timer:start()
		end
	end

	popup.update = function(text)
		icon.markup = text
	end

	popup.updateValue = function(vol)
		slider.value = vol
	end

	return popup
end

return create_popup
