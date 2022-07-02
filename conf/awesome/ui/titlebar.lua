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
    })

    -- Top thing
    local topthing = wibox.widget {
	    {
	    	widget = awful.titlebar.widget.titlewidget(c),
	    },
	    strategy = 'max',
	    width = dpi(250),
	    buttons = buttons,
	    widget = wibox.container.constraint,
    }

    local close_button = wibox.widget {
	    {
		    nil,
		    {
			    nil,
			    awful.titlebar.widget.closebutton(c),
			    expand = 'none',
			    layout = wibox.layout.align.horizontal,
		    },
		    expand = 'none',
		    layout = wibox.layout.align.horizontal,
	    },
	    margins = {top = dpi(8), bottom = dpi(8)},
	    widget = wibox.container.margin,
    }

    c:connect_signal("focus", function() close_button.visible = true end)
    c:connect_signal("unfocus", function() close_button.visible = false end)

    titlebar:setup {

	{
		{
			{
				close_button,
				topthing,
				spacing = dpi(20),
                                layout = wibox.layout.fixed.horizontal,
			},
			{
				buttons = buttons,
				layout = wibox.layout.align.horizontal,
			},
			{
				buttons = buttons,
				layout = wibox.layout.align.horizontal,
			},
			layout = wibox.layout.align.horizontal,
		},
		margins = {top = dpi(7), bottom = dpi(7), left = dpi(20), right = dpi(20)},
		widget = wibox.container.margin,
	},
	id = 'background_role',
	widget = wibox.container.background,
    }



end)
