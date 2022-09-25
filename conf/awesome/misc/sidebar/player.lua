local awful = require "awful"
local gears = require "gears"
local wibox = require "wibox"
local beautiful = require "beautiful"
local dpi = beautiful.xresources.apply_dpi

-- Make Widgets
-----------------

-- Song's Title
local title = wibox.widget.textbox()
title.font = "Roboto Medium 16"
title.align = "left"
title.valign = "center"

-- Song's Artist
local artist = wibox.widget.textbox()
artist.font = "Roboto Regular 16"
artist.align = "left"
artist.valign = "bottom"

-- Song's Length
local length = wibox.widget.textbox()
length.font = "Roboto Mono Regular 14"
length.align = "center"
length.valign = "center"

-- Player's Button
local toggle = wibox.widget.textbox()
toggle.font = "Roboto 26"

toggle:buttons(gears.table.join(
	awful.button({}, 1, function() 
		awful.spawn("playerctl -i firefox play-pause", false) 
		if toggle.markup:match("󰐊") then
			toggle.markup = "󰏤"
		else
			toggle.markup = "󰐊"
		end
	end)
))

local next = wibox.widget.textbox()
next.font = "Roboto 26"
next.markup = "󰒭"

next:buttons(gears.table.join(
	awful.button({}, 1, function() awful.spawn("playerctl next", false) end)
))

local back = wibox.widget.textbox()
back.font = "Roboto 26"
back.markup = "󰒮"

back:buttons(gears.table.join(
	awful.button({}, 1, function() awful.spawn("playerctl previous", false) end)
))

-- Get data
awesome.connect_signal("signal::player", function(t, a, l, s)
	if not s:match("Playing") then
		toggle.markup = "󰐊"
	else
		toggle.markup = "󰏤"
	end

	title.markup = t
	artist.markup = a
	length.markup = l
end)

-- Grouping Widgets
---------------------

local buttons = wibox.widget {
	back,
	toggle,
	next,
	spacing = dpi(8),
	layout = wibox.layout.fixed.horizontal,
}

return wibox.widget {
	{
		nil,
		{
			title,
			artist,
			layout = wibox.layout.fixed.vertical,
		},
		expand = 'none',
		layout = wibox.layout.align.vertical,
	},
	{
		nil,
		nil,
		{
			length,
			{
				nil,
				buttons,
				expand = 'none',
				layout = wibox.layout.align.horizontal,
			},
			spacing = dpi(12),
			layout = wibox.layout.fixed.vertical,
		},
		layout = wibox.layout.align.vertical,
	},
	layout = wibox.layout.flex.horizontal,
}
