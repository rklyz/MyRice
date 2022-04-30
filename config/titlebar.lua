local gears = require("gears")
local awful = require("awful")
local wibox = require("wibox")
local beautiful = require ("beautiful")
local dpi = beautiful.xresources.apply_dpi


----- Titlebar -----

client.connect_signal("request::titlebars", function(c)
    
    --- Set buttons var ---

    local buttons = gears.table.join(
        awful.button({ }, 1, function()
            c:emit_signal("request::activate", "titlebar", {raise = true})
            awful.mouse.client.move(c)
        end),
        awful.button({ }, 3, function()
            c:emit_signal("request::activate", "titlebar", {raise = true})
            awful.mouse.client.resize(c)
        end)
    )

    local titlebar = awful.titlebar (c, {
	size = dpi(50),
	position = 'left',
	bg_normal = beautiful.bg,
	bg_focus = beautiful.bg_alt,
    })

    titlebar:setup{
	{
		nil,
		{
			awful.titlebar.widget.closebutton(c),
			layout = wibox.layout.fixed.vertical,
		},
		nil,
		buttons = buttons,
		layout = wibox.layout.align.vertical,
	},
	margins = { top = dpi(5), bottom = dpi(5), left = dpi(8), right = dpi(4) },
	halign = 'center',
	widget = wibox.container.margin,
    }

end)

client.connect_signal("manage", function(c)
	c.shape = function(cr,w,h) gears.shape.rounded_rect(cr,w,h, 10) end
end)
