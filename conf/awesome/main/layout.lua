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

client.connect_signal("request::manage", function (c)
	if awesome.startup then awful.client.setslave(c) end
end)

-- Rounded Corners (I use picom so didn't need those btw)
--[[
client.connect_signal("request::manage", function(c) 
	if c.fullscreen or c.maximized then
                c.shape = function(cr,w,h) gears.shape.rectangle(cr,w,h) end
        else
                c.shape = function(cr,w,h) gears.shape.rounded_rect(cr,w,h,8) end
        end
end)

-- Disable Rounded Corners when fullscreen or maximized
local function disable_rounded(c) 
	if c.fullscreen or c.maximized then 
		c.shape = function(cr,w,h) gears.shape.rectangle(cr,w,h) end
	else
		c.shape = function(cr,w,h) gears.shape.rounded_rect(cr,w,h,8) end
	end
end

client.connect_signal("property::maximized", function(c)
	disable_rounded(c)
end)

client.connect_signal("property::fullscreen", function(c)
        disable_rounded(c)
end)
--]]

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

-- Disable titlebar when tiled
local disable_titlebar = function(t) 
	for k, c in ipairs(t:clients()) do 
		if awful.layout.get(mouse.screen) ~= awful.layout.suit.floating then 
			awful.titlebar.hide(c)
		else
			awful.titlebar.show(c)
		end
	end
end

tag.connect_signal('property::layout', function(t)
	disable_titlebar(t)
end)

client.connect_signal("request::manage", function(c) 
	if awful.layout.get(mouse.screen) ~= awful.layout.suit.floating then 
		awful.titlebar.hide(c)
	else
		awful.titlebar.show(c)
	end
end)
