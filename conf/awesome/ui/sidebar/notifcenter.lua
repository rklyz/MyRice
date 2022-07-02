local awful = require "awful"
local wibox = require "wibox"
local gears = require "gears"
local beautiful = require "beautiful"

local dpi = beautiful.xresources.apply_dpi
local rubato = require "lib.rubato"

----- Variables -----

width = dpi(320)
height = dpi(530)
gaps = dpi(20)

scr = awful.screen.focused()

----- Function to make life easier.. -----

local rr = function(cr,w,h) gears.shape.rounded_rect(cr,w,h,5) end

----- Notif's skeleton -----
local notifcenter = wibox {
	visible = false,
	ontop = true,
	bg = beautiful.bar,
	width = width,
	height = height,
	shape = rr,
	type = 'dock'
}

awful.placement.top_left(notifcenter, {margins = {top = dpi(510)}})

local notifslide = rubato.timed {
	pos = scr.geometry.x - notifcenter.width,
	rate = 60,
	intro = 0.2,
	duration = 0.4,
	subscribed = function(pos)
		notifcenter.x = scr.geometry.x + gaps + pos
	end
}

local toggle = function()
	if notifcenter.visible then
		notifslide.target = scr.geometry.x - notifcenter.width
		notifcenter.visible = not notifcenter.visible
	else
		notifslide.target = scr.geometry.x
		notifcenter.visible = not notifcenter.visible
	end
end

awesome.connect_signal("sidebar::toggle", function()
	toggle()
end)

----- Start making Notif Widgets! -----

