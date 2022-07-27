local awful = require "awful"
local gears = require "gears"
local wibox = require "wibox"
local beautiful = require "beautiful"

local apps = require "main.apps"

local launcher = wibox.widget.textbox()
launcher.font = "Roboto Mono 16"
launcher.markup = "󰍉"

launcher:connect_signal("mouse::enter", function()
	launcher.markup = "<span foreground='"..beautiful.black.."'>󰍉</span>"
end)

launcher:connect_signal("mouse::leave", function()
	launcher.markup = "󰍉"
end)

launcher:buttons(gears.table.join(
	awful.button({ }, 1, function() 
		awful.spawn(apps.launcher, false)
	end)
))

return launcher
