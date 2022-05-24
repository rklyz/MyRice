local awful = require "awful"
local gears = require "gears"
local beautiful = require "beautiful"

----- Client/Windows/Apps/Idk what to say... -----


--- Rounded Border/s

client.connect_signal("manage", function(c)
	c.shape = function(cr,w,h) gears.shape.rounded_rect(cr,w,h,5) end
end)

--- Focus when cursor enter any client

client.connect_signal("mouse::enter", function(c)
    c:activate { context = "mouse_enter", raise = false }
end)
