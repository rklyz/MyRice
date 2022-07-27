local awful = require "awful"
local gears = require "gears"
local beautiful = require "beautiful"

-- Layout
awful.layout.layouts = {
	awful.layout.suit.floating,
	awful.layout.suit.tile,
}

-- Client rules
client.connect_signal("mouse::enter", function(c)
	c:activate {context = "mouse_enter", raise = false}
end)

client.connect_signal("manage", function (c)
	if awesome.startup then awful.client.setslave(c) end
end)

-- Restore client after tiling layout
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
