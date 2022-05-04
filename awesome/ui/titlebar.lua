local awful = require "awful"
local wibox = require "wibox"
local beautiful = require "beautiful"
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

    local titlebar = awful.titlebar(c, {
	size = dpi(40),
	position = 'left',
    })

    titlebar:setup {

	{
		{
			nil,
			nil,
			{
				awful.titlebar.widget.closebutton(c),
				layout = wibox.layout.fixed.vertical,
			},
			layout = wibox.layout.align.vertical,
		},
		margins = { top = 10, bottom = 10, left = 4, right = 4},
		widget = wibox.container.margin,
	},
	bg = beautiful.bar_alt,
	widget = wibox.container.background,
    }



end)
