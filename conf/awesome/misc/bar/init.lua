local awful = require "awful"
local gears = require "gears"
local wibox = require "wibox"
local beautiful = require "beautiful"

local dpi = beautiful.xresources.apply_dpi

-- Get widgets
local clock = require "misc.bar.clock"
local wifi = require "misc.bar.wifi"
local volume = require "misc.bar.volume"
local launcher = require "misc.bar.launcher"
local menu = require "misc.bar.menu"

-- Right
local right = wibox.widget {
	{
		volume,
		wifi,
		clock,
		launcher,
		spacing = dpi(20),
		layout = wibox.layout.fixed.horizontal,
	},
	margins = {top = dpi(4), bottom = dpi(4), right = dpi(10)},
	widget = wibox.container.margin,
}

-- Left
local left = wibox.widget {
	{
		menu,
		layout = wibox.layout.fixed.horizontal,
	},
	margins = {top = dpi(4), bottom = dpi(4), left = dpi(10)},
	widget = wibox.container.margin,
}

-- Bar
local function get_bar(s)

	-- Tagbar
	require "misc.bar.tag"(s)

	local bar = wibox {
		visible = true,
		ontop = false,
		width = s.geometry.width,
		height = dpi(40),
		bg = beautiful.bg,
		type = 'dock'
	}

	bar:struts { top = dpi(60), left = dpi(20), right = dpi(20) }

	bar : setup {
		left,
		nil,
		right,
		layout = wibox.layout.align.horizontal,
	}
end

awful.screen.connect_for_each_screen(function(s)
	get_bar(s)
end)
