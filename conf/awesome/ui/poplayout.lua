local awful = require "awful"
local gears = require "gears"
local wibox = require "wibox"
local beautiful = require "beautiful"
local dpi = beautiful.xresources.apply_dpi

----- Var -----

local s = screen[1]
local width = dpi(100)
local height = dpi(100)

----- Widget -----

local l = awful.widget.layoutbox {
	screen = s
}

local layoutpop = awful.popup {
	ontop = true,
	placement = function(c)
		awful.placement.centered(c, {
			margins = {top = dpi(500)}
		})
	end,
	shape = gears.shape.rounded_rect,
	visible = false,
	widget = {
		{
			{
				l,
				layout = wibox.layout.align.vertical,
			},
			margins = dpi(20),
			widget = wibox.container.margin,
		},
		forced_width = width,
		forced_height = height,
		bg = beautiful.bar,
		widget = wibox.container.background,
	} -- Read from bottom for table
}

-- Timeout

local timeout = gears.timer {
	timeout = 1,
	autostart = true,
	call_timer = false,
	callback = function()
		layoutpop.visible = false
	end,
}

-- Connect to a signal

awesome.connect_signal("ui::layoutpop:open", function()
	layoutpop.visible = true
	if layoutpop.visible then
		timeout:again()
	else
		timeout:start()
	end
end)
