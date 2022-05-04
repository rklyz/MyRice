local gfs = require("gears.filesystem")
local gears = require("gears")
local awful = require("awful")
local wibox = require("wibox")
local beautiful = require("beautiful")
local dpi = beautiful.xresources.apply_dpi

----- Bar -----



screen.connect_signal("request::desktop_decoration", function(s)
    -- Each screen has its own tag table.
    awful.tag({ "1", "2", "3", "4", "5" }, s, awful.layout.layouts[1])

	----- Making Variables -----
	
	-- Time

	local hour = wibox.widget {
		format = "%H:%M",
		font = beautiful.font_name .. " " .. "14",
		widget = wibox.widget.textclock,
	}

	local date = wibox.widget {
		format = "%b %d,",
		font = beautiful.font_name .. " " .. "14",
		widget = wibox.widget.textclock,
	}

	local time = wibox.widget {
		{
			{
				date,
				hour,
				spacing = dpi(6),
				layout = wibox.layout.fixed.horizontal,
			},
			margins = dpi(4),
			widget = wibox.container.margin,
		},
		bg = beautiful.bg,
		widget = wibox.container.background,
	}

	-- layoutBox 
	
	local laybuttons = {
		awful.button({ }, 1, function () awful.layout.inc( 1) end),
      		awful.button({ }, 3, function () awful.layout.inc(-1) end),
    		awful.button({ }, 4, function () awful.layout.inc( 1) end),
        	awful.button({ }, 5, function () awful.layout.inc(-1) end),
	}
	
	local layoutbox = wibox.widget {
		{
			{
				buttons = laybuttons,
				widget = awful.widget.layoutbox,
			},
			margins = { top = dpi(6), bottom = dpi(6), right = dpi(4), left = dpi(4) },
			widget = wibox.container.margin,
		},
		bg = beautiful.bar,
		widget = wibox.container.background,
	}

	-- Tasklist
	
	local task = awful.widget.tasklist {
		screen = s,
		filter = awful.widget.tasklist.filter.focused,
		style = {
			shape = function(cr,w,h) gears.shape.rounded_rect(cr,w,h,10) end,
			font = beautiful.font_name .. " " .. "12",
		},
		layout = {
			spacing = dpi(2),
			layout = wibox.layout.fixed.horizontal,
		},
		widget_template = {
			{
				id = 'text_role',
				forced_width = dpi(200),
				widget = wibox.widget.textbox,
			},
			margins = dpi(4),
			widget = wibox.container.margin,
		},

	}

	-- Taglist/Workspaces
	
	local taglist_buttons = gears.table.join(
        	awful.button({ }, 1, function(t) t:view_only() end),
        	awful.button({ modkey }, 1, function(t)
                      	            	if client.focus then
                      	                	client.focus:move_to_tag(t)
                      	            	end
			    	end),
        	awful.button({ }, 3, awful.tag.viewtoggle),
        	awful.button({ modkey }, 3, function(t)
                                  	if client.focus then
                                      		client.focus:toggle_tag(t)
                                  	end
                              	end),
		awful.button({ }, 4, function(t) awful.tag.viewnext(t.screen) end),
		awful.button({ }, 5, function(t) awful.tag.viewprev(t.screen) end)
    	)
	
	local tag = awful.widget.taglist {
		screen = s,
		filter = awful.widget.taglist.filter.all,
		layout = {
			spacing = dpi(10),
			layout = wibox.layout.fixed.horizontal,
		},
		style = {
			font = beautiful.font_name .. " " .. beautiful.font_size,
		},
		buttons = taglist_buttons,
		widget_template = {
			{
				{
					id = 'text_role',
					widget = wibox.widget.textbox,
				},
				margins = dpi(4),
				widget = wibox.container.margin,
			},
			bg = beautiful.bar,
			widget = wibox.container.background,
		},

	}

	----- Set up the BAR -----
	

	s.bar = awful.wibar {
		position = 'top',
		width = s.geometry.width - dpi(200),
		height = dpi(50),
		screen = s,
		bg = beautiful.bar,
		visible = true,
	}

	s.bar.y = dpi(10)

	s.bar:setup {
		{
			{
				{
					{
						tag,
						task,
						spacing = dpi(15),
						layout = wibox.layout.fixed.horizontal,
					},
					nil,
					{
						time,
						layoutbox,
						spacing = dpi(10),
						layout = wibox.layout.fixed.horizontal,
					},
					layout = wibox.layout.align.horizontal,
				},
				margins = { top = dpi(2), bottom = dpi(2), right = dpi(10), left = dpi(10) },
				widget = wibox.container.margin,
			},
			border_width = dpi(2),
			border_color = beautiful.bar_alt,
			widget = wibox.container.background,
		},
		margins = dpi(6),
		widget = wibox.container.margin,
	}

end)
