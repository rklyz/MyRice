local gfs = require("gears.filesystem")
local gears = require("gears")
local awful = require("awful")
local wibox = require("wibox")
local beautiful = require("beautiful")
local dpi = beautiful.xresources.apply_dpi



----- Bar -----

screen.connect_signal("request::desktop_decoration", function(s)

    ----- Tags -----
    awful.tag({ "1", "2", "3", "4", "5" }, s, awful.layout.layouts[1])



    ----- Time -----
    local clock = wibox.widget {
	font = beautiful.font_name .. " " .. "16",
	format = '%H:%M /',
	align = 'center',
	valign = 'center',
	widget = wibox.widget.textclock,
    }

    local date = wibox.widget {
	font = beautiful.font_name .. " " .. "16",
	format = ' %A',
	align = 'center',
	valign = 'center',
	widget = wibox.widget.textclock,
    }

    local time = wibox.widget {
	{
		{
			clock,
			date,
			spacing = 0,
			layout = wibox.layout.fixed.horizontal,
		},
		left = 10,
		right = 10,
		widget = wibox.container.margin,
	},
	bg = beautiful.bar,
	shape = function(cr,w,h) gears.shape.rounded_rect(cr,w,h, 5) end,
	widget = wibox.container.background,
    }

    --- time's tooltip ---
    
    local time_t = awful.tooltip {
	objects = { time },
	delay_show = 0.5,
	margins = 10,
	shape = function(cr,w,h) gears.shape.rounded_rect(cr,w,h, 10) end,
    }

    time:connect_signal("mouse::enter", function()
	    time_t.text = os.date("%A, %B %d")
    end)


    
    ----- Stats -----

    --- Volume's circle ---
    
    local vol_arc = wibox.widget {
        {       
                {
                        markup = "<span foreground='" .. beautiful.blue .. "'><b></b></span>",
                        align = "center",
                        valign = "center",
                        widget = wibox.widget.textbox,
                },
                margins = { right = 2 },
                widget = wibox.container.margin,
        },
	value = 50,
	min_value = 0,
	max_value = 100,
	start_angle = math.pi / 2,
	thickness = 3,
	colors = { '#8DA3B9' },
	bg = beautiful.bar,
	widget = wibox.container.arcchart,
    }

    --- Receive signal from wave/volume ---

    awesome.connect_signal("signal::volume", function(vol)
	    vol_arc.value = vol
    end)

    --- Brightness's circle ---

    local bri_arc = wibox.widget {
	{       
		{
                	markup = "<span foreground='" .. beautiful.yellow .. "'><b></b></span>",
			font = beautiful.font_name .. " " .. beautiful.font_size,
                	align = "center",
                	valign = "center",
                	widget = wibox.widget.textbox,
		},
		margins = { right = 2 },
		widget = wibox.container.margin,
        },
	value = 50,
        min_value = 5,
        max_value = 50,
        start_angle = math.pi / 2,
        thickness = 3,
        colors = { '#D9BC8C' },
        bg = beautiful.bar_bg,
        widget = wibox.container.arcchart,
    }

    --- receive brightness's wave ---
    
    awesome.connect_signal("signal::brightness", function(bri)
	    bri_arc.value = bri
    end)

    --- Define Stat ---

    local stat = wibox.widget {
	{
		{
			vol_arc,
			bri_arc,
			spacing = 10,
			layout = wibox.layout.fixed.horizontal,
		},
		margins = 5,
		widget = wibox.container.margin,
	},
	shape = function(cr,w,h) gears.shape.rounded_rect(cr,w,h,5) end,
	bg = beautiful.bar_alt,
	widget = wibox.container.background,
    }



    ----- Awesome icon -----

    local awesome_icon = wibox.widget {
	image = '/home/neko/.config/awesome/theme/awesome.png',
	resize = true,
	widget = wibox.widget.imagebox,
    }


    ----- layoutbox -----

    local layoutbox = wibox.widget {
	{
		{
			{
				widget = awful.widget.layoutbox,
				buttons = {
					awful.button({ }, 1, function () awful.layout.inc( 1) end),
					awful.button({ }, 4, function () awful.layout.inc( 1) end),
					awful.button({ }, 5, function () awful.layout.inc(-1) end),
				},
			},
			margins = { left = 10, right = 10, top = 6, bottom = 6, },
			widget = wibox.container.margin,
		},
		bg = beautiful.bar,
		widget = wibox.container.background,
	},
	margins = dpi(0),
	widget = wibox.container.margin,
    }


    ----- TagList -----
   

    --- Taglist's button var ---

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


  
    --- Define Taglist ---

    local taglist = awful.widget.taglist {
	screen = s,
	filter = awful.widget.taglist.filter.all,
	buttons = taglist_buttons,
	style = {
		shape = function(cr,w,h) gears.shape.squircle(cr,w,h,2, .1) end,
		font = beautiful.font_name .. " " .. beautiful.font_size,
	},
	layout   = {
            spacing = 10,
            layout = wibox.layout.fixed.horizontal
        },	
	widget_template = {
		{
			{
				id = 'text_role',
				widget = wibox.widget.textbox,
			},
			left = 5,
			right = 5,
			widget = wibox.container.margin,
		},
		-- id = 'background_role',     -- Background for every tag
		widget = wibox.container.background,
	},
    }

    local tag = wibox.widget {
	{
		taglist,
		layout = wibox.layout.align.horizontal,
	},
	margins = 3,
	widget = wibox.container.margin,
    }


    
    ----- Tasklist -----

    local tasklist = awful.widget.tasklist {
	screen = s,
	filter = awful.widget.tasklist.filter.focused,
	style = {
		shape = function(cr,w,h) gears.shape.rounded_rect(cr,w,h,10) end,
		font = beautiful.font_name .. " " .. "16",
	},
	layout = {
		spacing = 10,
		layout = wibox.layout.fixed.horizontal,
	},
	buttons = {
		awful.button({}, 1, function(c)
        		c:activate { context = "tasklist", action = "toggle_minimization" }
      		end),
	},
	widget_template = {
		{
			{
				id = "text_role",
				widget = wibox.widget.textbox,
			},
			margins = {top = 5, bottom = 5, left = 10, right = 10},
			widget = wibox.container.margin,
		},
		shape = function(cr,w,h) gears.shape.rounded_rect(cr,w,h, 5) end,
		id = "background_role",
		widget = wibox.container.background,
	},
    }

    local task = wibox.widget {
	{
		tasklist,
		layout = wibox.layout.fixed.horizontal,
	},
	widget = wibox.container.background,
    }



    ----- Set Bar -----



    s.wibar = awful.wibar {
	position = 'top',
	screen = s,
	width = s.geometry.width - dpi(100),
	height = 50,
	-- shape = function(cr,w,h) gears.shape.rounded_rect(cr,w,h,10) end,
	bg = beautiful.bar,
	visible = true,
    }

    s.wibar.y = 10

    ----- Insert all the widgets into the bar -----
    
    s.wibar:setup {
	{
		{
			{
				{
					tag,
					task,
					spacing = dpi(10),
					layout = wibox.layout.fixed.horizontal,
				},
				nil,
				{
					time,
					layoutbox,
					layout = wibox.layout.fixed.horizontal,
				},
				layout = wibox.layout.align.horizontal,
			},
			margins = dpi(4),
			widget = wibox.container.margin,
		},
		border_width = dpi(2),
		border_color = beautiful.bar_alt,
		widget = wibox.container.background,
	},
	margins = 6,
	widget = wibox.container.margin,
    }


end)
