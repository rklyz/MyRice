local awful = require "awful"
local gears = require "gears"
local wibox = require "wibox"
local beautiful = require "beautiful"
local dpi = beautiful.xresources.apply_dpi

local rubato = require "lib.rubato"

-- Var
local width = dpi(420)
local height = awful.screen.focused().geometry.height

-- Get widgets
local clock = require "misc.sidebar.clock"
local profile = require "misc.sidebar.profile"
local weather = require "misc.sidebar.weather"
local temperature = require "misc.sidebar.temperature"
local wifi = require "misc.sidebar.wifi"
local uptime = require "misc.sidebar.uptime"
local slider = require "misc.sidebar.sliders"

-- Combine some widgets
local widgets = wibox.widget {
	nil,
	{
		{
			weather,
			temperature,
			wifi,
			uptime,
			spacing = dpi(40),
			layout = wibox.layout.fixed.vertical,
		},
		margins = {left = dpi(20), right = dpi(20)},
		widget = wibox.container.margin,
	},
	expand = 'none',
	layout = wibox.layout.align.horizontal,
}

local slider_widget = wibox.widget {
	nil,
	{
		widget = slider
	},
	expand = 'none',
	layout = wibox.layout.align.horizontal,
}

-- Spacing
local space = function(height)
	return wibox.widget {
		forced_height = dpi(height),
		layout = wibox.layout.align.horizontal
	}
end

-- Sidebar
local sidebar = wibox {
	visible = false,
	ontop = true,
	width = width,
	height = height,
	bg = beautiful.bg,
	type = 'dock'
}

-- Sidebar widget setup
sidebar : setup {
	nil,
	{
		clock,
		space(30),
		profile,
		space(30),
		slider_widget,
		space(50),
		widgets,
		layout = wibox.layout.fixed.vertical,
	},
	expand = 'none',
	layout = wibox.layout.align.vertical, 
}

-- Slide animation
local slide = rubato.timed {
	pos = awful.screen.focused().geometry.x - sidebar.width,
	rate = 60,
	intro = 0.2,
	duration = 0.4,
	subscribed = function(pos) 
		sidebar.x = awful.screen.focused().geometry.x + pos
	end
}

-- Timer of sidebar's death 
sidebar.timer = gears.timer {
	timeout = 0.5,
	single_shot = true,
	callback = function() 
		sidebar.visible = not sidebar.visible
	end
}

-- Toggle function
sidebar.toggle = function()
	if sidebar.visible then 
		slide.target = awful.screen.focused().geometry.x - sidebar.width
		sidebar.timer:start()
	else
		slide.target = awful.screen.focused().geometry.x
		sidebar.visible = not sidebar.visible
	end
end

-- Get signal to execute the function (if that makes sense)
awesome.connect_signal("sidebar::toggle", function()
	sidebar.toggle()
end)

return sidebar
