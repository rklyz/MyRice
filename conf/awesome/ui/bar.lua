local gfs = require("gears.filesystem")
local gears = require("gears")
local awful = require("awful")
local wibox = require("wibox")
local beautiful = require("beautiful")
local dpi = beautiful.xresources.apply_dpi

local rubato = require "lib.rubato"

----- Bar -----

screen.connect_signal("request::desktop_decoration", function(scr)
    -- Each screen has its own tag table.
    awful.tag({ "1", "2", "3", "4", "5" }, s, awful.layout.layouts[1])


	-- Setting up the bar
	scr.leftbar = awful.wibar {
		position = 'top',
		screen = scr,
		width = dpi(320),
		height = dpi(60),
		margins = {top = dpi(20)},
		shape = function(cr,w,h) gears.shape.rounded_rect(cr,w,h,5) end,
		bg = beautiful.bar,
	}

	scr.leftbar.x = dpi(20)

	scr.leftbar:struts { top = dpi(90), left = dpi(20), right = dpi(20)}

	-- Taglist
	local btn_tag = awful.button({ }, 1, function(t) t:view_only() end)

	local taglist = awful.widget.taglist {
		screen = scr,
		filter = awful.widget.taglist.filter.all,
		layout = {
			spacing = dpi(20),
			layout = wibox.layout.fixed.horizontal
		},
		style = {
			font = beautiful.font_name .. " Bold 14",
		},
		buttons = btn_tag,
		widget_template = {
			{
				{
					id = 'text_role',
					widget = wibox.widget.textbox,
				},
				margins = dpi(0),
				widget = wibox.container.margin,
			},
			widget = wibox.container.background,
		}
	}

	-- Clock
	local time = wibox.widget.textbox()

	gears.timer {
		timeout = 60,
		call_now = true,
		autostart = true,
		callback = function()
			tmp = os.date("%I:%M %p")
			time.markup = "󱑂 " .. tmp
		end
	}

	time:buttons(gears.table.join(
		awful.button({ }, 1, function()
			awesome.emit_signal('sidebar::toggle')
		end)
	))

	local left = wibox.widget {
		{ 
			{
				taglist,
				time,
				spacing = dpi(40),
				layout = wibox.layout.fixed.horizontal,
			},
			margins = {top = dpi(10), bottom = dpi(10), left = dpi(20), right = dpi(20)},
			widget = wibox.container.margin, 
		},
		bg = beautiful.bar,
		widget = wibox.container.background,
	}

	scr.leftbar : setup {
		nil,
		{
			left,
			nil,
			nil,
			layout = wibox.layout.align.horizontal,
		},
		expand = 'none',
		layout = wibox.layout.align.horizontal,
	}

end)
