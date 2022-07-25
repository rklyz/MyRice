local gfs = require("gears.filesystem")
local gears = require("gears")
local awful = require("awful")
local wibox = require("wibox")
local naughty = require ("naughty")
local beautiful = require("beautiful")
local dpi = beautiful.xresources.apply_dpi

local rubato = require "lib.rubato"

-- Get some widget

local clock = require "ui.bar.clock"
local wifi = require "ui.bar.wifi"
local launcher = require "ui.bar.launcher"
local power = require "ui.bar.power"
local volume = require "ui.bar.volume"

----- Bar -----

screen.connect_signal("request::desktop_decoration", function(scr)
    -- Each screen has its own tag table.
    awful.tag({ "1", "2", "3", "4", "5" }, s, awful.layout.layouts[1])


	-- Setting up the bar

	require "ui.bar.taglist"

	local bar = wibox {
		visible = true,
		ontop = false,
		width = scr.geometry.width,
		height = dpi(40),
		bg = beautiful.bar,
		type = 'dock'
	}

	-- Leftbar options
	awful.placement.top(bar)
	bar:struts { top = dpi(60), left = dpi(20), right = dpi(20)}

	-- pfp
	local your_image = wibox.widget.imagebox()
	your_image.image = beautiful.pfp
	your_image.clip_shape = gears.shape.circle
	your_image.resize = true
	your_image.halign = 'center'

	your_image:buttons(gears.table.join(
		awful.button({ }, 1, function()
			awesome.emit_signal('sidebar::toggle')
		end)
	))

	-- Right group
	local right = wibox.widget {
		{ 
			{
				volume,
				wifi,
				clock,
				power,
				spacing = dpi(20),
				layout = wibox.layout.fixed.horizontal,
			},
			margins = {top = dpi(4), bottom = dpi(4), right = dpi(10)},
			widget = wibox.container.margin, 
		},
		bg = beautiful.bar,
		widget = wibox.container.background,
	}

	-- Left group
	local left = wibox.widget {
		{
			{
				launcher,
				spacing = dpi(40),
				layout = wibox.layout.fixed.horizontal,
			},
			margins = {top = dpi(4), bottom = dpi(4), left = dpi(4), right = dpi(4)},
			widget = wibox.container.margin,
		},
		widget = wibox.container.background,
	}

	bar : setup {
		left,
		nil,
		right,
		layout = wibox.layout.align.horizontal,
	}

end)
