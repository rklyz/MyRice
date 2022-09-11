local awful = require "awful"
local wibox = require "wibox"
local gears = require "gears"
local beautiful = require "beautiful"
local dpi = beautiful.xresources.apply_dpi

-- Menu
local menu = wibox.widget.textbox()
menu.font = "Roboto 16"
menu.markup = "󰍜"

menu:connect_signal("mouse::enter", function() 
	menu.markup = "<span foreground='"..beautiful.bg_alt.."'>󰍜</span>"
end)

menu:connect_signal("mouse::leave", function()
	menu.markup = "󰍜"
end)

menu:buttons(gears.table.join(
	awful.button({ }, 1, function()
		awesome.emit_signal("sidebar::toggle")
	end)
))

return menu
