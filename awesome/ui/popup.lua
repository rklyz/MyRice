local wibox = require "wibox"
local awful = require "awful"
local beautiful = require "beautiful"
local gears = require "gears"
local dpi = beautiful.xresources.apply_dpi

----- Var -----

local height = dpi(175)
local width = dpi(50)

local popup = awful.popup { widget = wibox.container.margin,
	ontop = true,
	visible = false,
	placement = function(c)
		awful.placement.top_right(c, {margins = {top = dpi(100), right = dpi(50)}})
	end,
}

local icon = wibox.widget {
	{
		markup = "<span><b>H</b></span>",
		widget = wibox.widget.textbox,
	},
	widget = wibox.container.place,
	halign = "center",
}

local bar = wibox.widget {
	{
		max_value = 100,
		color = beautiful.bar,
		background_color = beautiful.bar,
		border_width = dpi(2),
		border_color = beautiful.bar_alt,
		value = 100,
		paddings = dpi(2),
		widget = wibox.widget.progressbar,
	},
	forced_height = dpi(120),
	direction = "east",
	layout = wibox.container.rotate,
}

popup.widget = wibox.widget {
	{
		{
			{
				{
					wibox.container.margin(bar, dpi(6), dpi(6), dpi(4)),
					icon,
					spacing = dpi(4),
					layout = wibox.layout.fixed.vertical,
				},
				margins = dpi(7),
				widget = wibox.container.margin,
			},
			border_color = beautiful.bar_alt,
			border_width = dpi(2),
			widget = wibox.container.background,
		},
		margins = dpi(4),
		widget = wibox.container.margin,
	},
	forced_width = width,
	forced_height = height,
	bg = beautiful.bar,
	widget = wibox.container.background,
}

local timeout = gears.timer {
	timeout = 5,
	autostart = true,
	callback = function()
		popup.visible = false
	end
}

local first_time = true
awesome.connect_signal("signal::volume", function(vol,mute)

	if first_time then
		first_time = false
	else
		if mute or vol == 0 then
			bar.widget.value = 0
		else
			bar.widget.value = vol
			bar.widget.max_value = 100
			bar.widget.color = beautiful.blue
			icon.widget.markup = "<span foreground='" .. beautiful.blue .. "'><b></b></span>"
		end

		if popup.visible then
			timeout:again()
		else
			popup.visible = true
			timeout:start()
		end
	end
end)

awesome.connect_signal("signal::brightness", function(bri)

	popup.visible = true
	bar.widget.value = bri
	bar.widget.max_value = 40
	bar.widget.color = beautiful.yellow
	icon.widget.markup = "<span foreground='" .. beautiful.yellow .. "'><b></b></span>"

	if popup.visible then
                 timeout:again()
        else
                 popup.visible = true
                 timeout:start()
        end
end)
