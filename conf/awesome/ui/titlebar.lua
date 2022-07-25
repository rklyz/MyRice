local awful = require "awful"
local wibox = require "wibox"
local beautiful = require "beautiful"
local gears = require "gears"
local dpi = beautiful.xresources.apply_dpi


----- Titlebar/s -----


client.connect_signal("request::titlebars", function(c)
    -- buttons for the titlebar
    local buttons = {
        awful.button({ }, 1, function()
            c:activate { context = "titlebar", action = "mouse_move"  }
        end),
        awful.button({ }, 3, function()
            c:activate { context = "titlebar", action = "mouse_resize"}
        end),
    }

    -- Set the titlebar

    local titlebar = awful.titlebar(c, {
	size = dpi(50),
	position = 'top',
	bg = beautiful.transparent,
    })

    -- Top thing
    local topthing = wibox.widget {
	    {
		align = "right",
	    	widget = awful.titlebar.widget.titlewidget(c),
	    },
	    strategy = 'max',
	    width = dpi(250),
	    buttons = buttons,
	    widget = wibox.container.constraint,
    }

    local titlebar_buttons = wibox.widget {
	    {
		    nil,
		    {
			    nil,
			    {
				    awful.titlebar.widget.closebutton(c),
				    awful.titlebar.widget.maximizedbutton(c),
				    awful.titlebar.widget.minimizebutton(c),
				    spacing = dpi(10),
				    layout = wibox.layout.fixed.horizontal,
			    },
			    expand = 'none',
			    layout = wibox.layout.align.horizontal,
		    },
		    expand = 'none',
		    layout = wibox.layout.align.horizontal,
	    },
	    margins = {top = dpi(5), bottom = dpi(5)},
	    widget = wibox.container.margin,
    }

    local container = wibox.widget {
	    bg = beautiful.bar_alt,
	    shape = function(cr,w,h) gears.shape.partially_rounded_rect(cr,w,h,true,true,false,false,5) end,
	    widget = wibox.container.background,
    }

    c:connect_signal("focus", function() container.bg = beautiful.bar_alt end)
    c:connect_signal("unfocus", function() container.bg = beautiful.bar end)

    titlebar:setup {

	{
		{
			{
				titlebar_buttons,
				spacing = dpi(20),
                                layout = wibox.layout.fixed.horizontal,
			},
			{
				buttons = buttons,
				layout = wibox.layout.align.horizontal,
			},
			{
				--topthing,
				buttons = buttons,
				layout = wibox.layout.align.horizontal,
			},
			layout = wibox.layout.align.horizontal,
		},
		margins = {top = dpi(7), bottom = dpi(7), left = dpi(20), right = dpi(20)},
		widget = wibox.container.margin,
	},
	widget = container,
    }



end)
