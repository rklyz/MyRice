local awful = require "awful"
local gears = require "gears"
local wibox = require "wibox"
local beautiful = require "beautiful"

local supporter = require "supporter"

-- Launcher
local launcher = supporter.create_button("󰍉", "Roboto Medium 16", beautiful.fg_normal, beautiful.black, function()
	awful.spawn("rofi -show drun", false)
end)

return launcher
