local awful = require "awful"
local gears = require "gears"
local beautiful = require "beautiful"
local dpi = beautiful.xresources.apply_dpi

----- Client/Windows/Apps/Idk what to say... -----

screen[1].padding = {
	top = dpi(0),
	bottom = dpi(0),
	left = dpi(0),
	right = dpi(0)
}

--- Rounded Border/s
-- see conf/titlebar
--[[
client.connect_signal("manage", function(c, startup)
	if not c.fullscreen or c.maximized then
		c.shape = function(cr,w,h) gears.shape.partially_rounded_rect(cr,w,h,false,false,true,true, 5) end
	end
end)

local no_rounded_corners = function(c)
	if c.fullscreen or c.maximized then
		c.shape = function(cr,w,h) gears.shape.rectangle(cr,w,h) end
	else
		c.shape = function(cr,w,h) gears.shape.partially_rounded_rect(cr,w,h,false,false,true,true, 5) end
	end
end

-- No rounded corners for fullscreen/maximized client
client.connect_signal("property::fullscreen", function(c)
	no_rounded_corners(c)
end)

client.connect_signal("property::maximized", function(c)
	no_rounded_corners(c)
end)

--]]

--- Focus when cursor enter any client

client.connect_signal("mouse::enter", function(c)
    c:activate { context = "mouse_enter", raise = false }
end)

--- Restore client for floating layout 
-- Copy cat from --> Ner0z
tag.connect_signal('property::layout', function(t)
    for k, c in ipairs(t:clients()) do
        if awful.layout.get(mouse.screen) == awful.layout.suit.floating then
            local cgeo = awful.client.property.get(c, 'floating_geometry')
            if cgeo then
                c:geometry(awful.client.property.get(c, 'floating_geometry'))
            end
        end
    end
end)

client.connect_signal('manage', function(c)
    if awful.layout.get(mouse.screen) == awful.layout.suit.floating then
        awful.client.property.set(c, 'floating_geometry', c:geometry())
    end
end)

client.connect_signal('property::geometry', function(c)
    if awful.layout.get(mouse.screen) == awful.layout.suit.floating then
        awful.client.property.set(c, 'floating_geometry', c:geometry())
    end
end)
