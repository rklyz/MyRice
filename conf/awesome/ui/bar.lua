local gfs = require("gears.filesystem")
local gears = require("gears")
local awful = require("awful")
local wibox = require("wibox")
local beautiful = require("beautiful")
local dpi = beautiful.xresources.apply_dpi

----- Bar -----



screen.connect_signal("request::desktop_decoration", function(s)
    -- Each screen has its own tag table.
    awful.tag({ "一", "二", "三", "四", "五" }, s, awful.layout.layouts[1])

	----- Making Variables -----
	
	-- Time

	local hour = wibox.widget {
		font = beautiful.font_name .. " " .. "14",
		widget = wibox.widget.textbox,
	}

	local time = wibox.widget {
		{
			{
				hour,
				spacing = dpi(6),
				layout = wibox.layout.fixed.horizontal,
			},
			margins = dpi(4),
			widget = wibox.container.margin,
		},
		shape = function(cr,w,h) gears.shape.rounded_rect(cr,w,h,5) end,
		bg = beautiful.bar,
		widget = wibox.container.background,
	}

	local set_clock = function()
		_ = os.date("%H:%M")
		hour.markup = "<span foreground='" .. beautiful.crayola .. "'>" .. _ .. "</span>"
	end

	local update_clock = gears.timer {
		timeout = 5,
		autostart = true,
		call_now = true,
		callback = function()
			set_clock()
		end
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

	-- Volume
	
	local volume = wibox.widget {
		{
			{
				{
					id = "vol_icon",
					markup = "<span foreground='" .. beautiful.blue .. "'></span>",
                			widget = wibox.widget.textbox,
				},
				{
					id = "value",
					markup = "",
					widget = wibox.widget.textbox,
				},
				spacing = dpi(4),
				id = "vol_layout",
				layout = wibox.layout.fixed.horizontal,
			},
			id = "container",
			margins = dpi(6),
			widget = wibox.container.margin,
		},
		shape = function(cr,w,h) gears.shape.rounded_rect(cr,w,h,5) end,
		bg = beautiful.bar_alt,
		widget = wibox.container.background,
	}

	awesome.connect_signal("signal::volume", function(vol,mute)

		volume.container.vol_layout.value.markup = "<span foreground='" .. beautiful.blue .. "'>" .. vol .. "%</span>"

		if mute or vol == 0 then
			volume.container.vol_layout.vol_icon.markup = "<span foreground='" .. beautiful.blue .. "'></span>"
		else
			if tonumber(vol) > 79 then
				volume.container.vol_layout.vol_icon.markup = "<span foreground='" .. beautiful.blue .. "'></span>"
			elseif tonumber(vol) >= 1 then
				volume.container.vol_layout.vol_icon.markup = "<span foreground='" .. beautiful.blue .. "'></span>"
			else
				volume.container.vol_layout.vol_icon.markup = "<span foreground='" .. beautiful.blue .. "'></span>"
			end
		end
	end)

	-- Brightness 
	
	local bright = wibox.widget {
		{
			{
				{
					id = "bri_icon",
                                        markup = "<span foreground='" .. beautiful.yellow .. "'></span>",
                                        widget = wibox.widget.textbox
				},
				{
					id = "value",
					markup = "<span foreground='" .. beautiful.yellow .. "'></span>",
					widget = wibox.widget.textbox
				},
				id = "bri_layout",
				spacing = dpi(4),
				layout = wibox.layout.fixed.horizontal,
			},
			id = "container",
			margins = dpi(6),
			widget = wibox.container.margin,
		},
		shape = function(cr,w,h) gears.shape.rounded_rect(cr,w,h,5) end,
		bg = beautiful.bar_alt,
		widget = wibox.container.background,
	}

	awesome.connect_signal("signal::brightness", function(bri)

		_ = tostring(bri)
		bri_val = _:match("(%d+)[.]")

		bright.container.bri_layout.value.markup = "<span foreground='" .. beautiful.yellow .. "'>" .. bri_val .."%</span>"

		if tonumber(os.date("%H")) < 7 then
			bright.container.bri_layout.bri_icon.markup = "<span foreground='" .. beautiful.yellow .. "'></span>"
		elseif tonumber(os.date("%H")) < 19 then
			bright.container.bri_layout.bri_icon.markup = "<span foreground='" .. beautiful.yellow .. "'></span>"
		else
			bright.container.bri_layout.bri_icon.markup = "<span foreground='" .. beautiful.yellow .. "'></span>"
		end
        end)

	-- Wifi
	
	local wifi = wibox.widget {
		{
                        {
                                {
                                        id = "wifi_icon",
                                        markup = "<span foreground='" .. beautiful.red .. "'></span>",
                                        widget = wibox.widget.textbox
                                },
				{
                                        id = "ssid",
                                        markup = "<span foreground='" .. beautiful.red .. "'></span>",
                                        widget = wibox.widget.textbox
                                },
				spacing = dpi(4),
                                id = "wifi_layout",
                                layout = wibox.layout.fixed.horizontal,
                        },
                        id = "container",
                        margins = dpi(6),
                        widget = wibox.container.margin,
                },
		shape = function(cr,w,h) gears.shape.rounded_rect(cr,w,h,5) end,
                bg = beautiful.bar_alt,
                widget = wibox.container.background
	}

	-- Connect signal named "signal::wifi"
	awesome.connect_signal("signal::wifi", function(stat, ssid)

		net_ssid = ssid:match(".[^:]+")

		if not stat then
			wifi.container.wifi_layout.wifi_icon.markup = "<span foreground='" .. beautiful.red .. "'></span>"
			wifi.container.wifi_layout.ssid.markup = "<span foreground='" .. beautiful.red .. "'>".. net_ssid .."</span>"
		else
			wifi.container.wifi_layout.wifi_icon.markup = "<span foreground='" .. beautiful.green .. "'></span>"
			wifi.container.wifi_layout.ssid.markup = "<span foreground='" .. beautiful.green .. "'>".. net_ssid .."</span>"
		end
	end)

	-- Info

	local info = wibox.widget {
		{
			{
				wifi,
				volume,
				bright,
				spacing = dpi(10),
				layout = wibox.layout.fixed.horizontal,
			},
			margins = { left = dpi(4), right = dpi(4) },
			widget = wibox.container.margin,
		},
		shape = function(cr,w,h) gears.shape.rounded_rect(cr,w,h,5) end,
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
	
	local tags = awful.widget.taglist {
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
					nil,
					{
						id = 'text_role',
						forced_width = dpi(25),
						align = 'center',
						widget = wibox.widget.textbox,
					},
					{
						wibox.widget.base.make_widget(),
						forced_height = dpi(2),
						id = 'background_role',
						widget = wibox.container.background,
					},
					layout = wibox.layout.align.vertical,
				},
				margins = dpi(4),
				widget = wibox.container.margin,
			},
			widget = wibox.container.background,

		},

	}

	local tag = wibox.widget {
		{
			{
				tags,
				layout = wibox.layout.fixed.horizontal,
			},
			margins = { left = dpi(5), right = dpi(5) },
			widget = wibox.container.margin,
		},
		shape = function(cr,w,h) gears.shape.rounded_rect(cr,w,h,5) end,
		bg = beautiful.bar_alt,
		widget = wibox.container.background,
	}

	----- Set up the BAR -----
	

	s.bar = awful.wibar {
		position = 'top',
		width = s.geometry.width, -- dpi(200),
		height = dpi(50),
		screen = s,
		bg = beautiful.bar,
		visible = true,
		--shape = function(cr,w,h) gears.shape.rounded_rect(cr,w,h,10) end,
	}

	s.bar.y = dpi(0)

	s.bar:setup {
		{
			{
				tag,
				spacing = dpi(15),
				layout = wibox.layout.fixed.horizontal,
			},
			nil,
			{
				info,
				time,
				layoutbox,
				spacing = dpi(5),
				layout = wibox.layout.fixed.horizontal,
			},
			layout = wibox.layout.align.horizontal,
		},
	margins = dpi(8),
	widget = wibox.container.margin,
	} -- Tips: Read/Write the codes from bottom for :setup or widget_template

end)
