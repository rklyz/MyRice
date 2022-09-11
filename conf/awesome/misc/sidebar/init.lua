local awful = require "awful"
local gears = require "gears"
local wibox = require "wibox"
local beautiful = require "beautiful"
local dpi = beautiful.xresources.apply_dpi

local rubato = require "lib.rubato"

-- Var
local width = dpi(420)
local height = awful.screen.focused().geometry.height - dpi(100)

-- Helper
-----------

local function round_widget(radius)
	return function(cr,w,h)
		gears.shape.rounded_rect(cr,w,h,radius)
	end
end

local function center_widget(widgets)
	return wibox.widget {
		nil,
		{
			nil,
			widgets,
			expand = 'none',
			layout = wibox.layout.align.horizontal,
		},
		expand = 'none',
		layout = wibox.layout.align.vertical,
	}
end

local function box_widget(widgets, width, height)
	--local centered_widget = center_widget(widgets)

	return wibox.widget {
		{
			{
				widgets,
				margins = dpi(16),
				widget = wibox.container.margin,
			},
			forced_width = dpi(width),
			forced_height = dpi(height),
			shape = round_widget(8),
			bg = beautiful.bg_alt,
			widget = wibox.container.background,
		},
		margins = {left = dpi(20), right = dpi(20)},
		widget = wibox.container.margin,
	}
end

local aa = wibox.widget.textbox()

-- Get widgets
local profile_widget = require "misc.sidebar.profile"
local player_widget = require "misc.sidebar.player"
local stats_widget = require "misc.sidebar.stats"
local calendar_widget = require "misc.sidebar.calendar"

-- Combine some widgets
local profile = box_widget(profile_widget, 380, 210)
local player = box_widget(player_widget, 380, 150)
local stats = box_widget(stats_widget, 380, 180)
local calendar = box_widget(calendar_widget, 380, 330)

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
	y = dpi(20),
	bg = beautiful.bg,
}

-- Sidebar widget setup
sidebar : setup {
	{
		profile,
		player,
		stats,
		calendar,
		spacing = dpi(20),
		layout = wibox.layout.fixed.vertical,
	},
	margins = { top = dpi(20), bottom = dpi(20)},
	widget = wibox.container.margin,
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
		slide.target = awful.screen.focused().geometry.x + dpi(20)
		sidebar.visible = not sidebar.visible
	end
end

-- Get signal to execute the function (if that makes sense)
awesome.connect_signal("sidebar::toggle", function()
	sidebar.toggle()
end)

return sidebar
