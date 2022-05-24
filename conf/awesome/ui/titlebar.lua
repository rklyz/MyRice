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
	size = dpi(40),
	position = 'left',
    })

    -- Set the button for the titlebar
    -- Ex. Minbutton, Closebutton

    local c_button = wibox.widget {
	forced_width = dpi(15),
	forced_height = dpi(15),
	shape = function(cr,w,h) gears.shape.circle(cr,w,h) end,
	bg = beautiful.taglist_fg_empty,
	widget = wibox.container.background,
    }

    local min_button = wibox.widget {
	forced_height = dpi(15),
	forced_width = dpi(15),
	shape = function(cr,w,h) gears.shape.circle(cr,w,h) end,
	bg = beautiful.taglist_fg_empty,
	widget = wibox.container.background,
    }

    -- Buttons's behavior (kinda)

    c_button:connect_signal("button::release", function()
	    c:kill()
    end)

    min_button:connect_signal("button::release", function()
	    c.minimized = true
    end)

    local function updt_color ()
	    if client.focus == c then
		    c_button.bg = beautiful.red
		    min_button.bg = beautiful.blue
	    else
		    c_button.bg = beautiful.taglist_fg_empty
		    min_button.bg = beautiful.taglist_fg_empty
	    end
    end

    c:connect_signal("focus", updt_color)
    c:connect_signal("unfocus", updt_color)
    
    -- Titlebar's skelleton

    titlebar:setup {

	{
		{
			{
				c_button,
				min_button,
				spacing = dpi(10),
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
