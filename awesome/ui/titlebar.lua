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
			{
				awful.titlebar.widget.closebutton(c),
				layout = wibox.layout.fixed.vertical,
			},
			{
				buttons = buttons,
				layout = wibox.layout.fixed.vertical,
			},
			{
				buttons = buttons,
				layout = wibox.layout.fixed.vertical,
			},
			layout = wibox.layout.align.vertical,
		},
		margins = { top = 12, bottom = 12, left = 11, right = 11},
		widget = wibox.container.margin,
	},
	id = 'background_role',
	widget = wibox.container.background,
    }



end)
