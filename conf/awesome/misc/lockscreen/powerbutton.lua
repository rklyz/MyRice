local awful = require "awful"
local gears = require "gears"
local wibox = require "wibox"
local beautiful = require "beautiful"

local create_button = require "misc.lockscreen.create_buttons"

local poweroff = create_button("󰐥", "Poweroff", beautiful.red, "poweroff")
local reboot = create_button("󰜉", "Reboot", beautiful.yellow, "reboot")
local sleep = create_button("󰤄", "Sleep", beautiful.blue, "systemctl suspend")

return wibox.widget {
	poweroff,
	reboot,
	sleep,
	spacing = 20,
	layout = wibox.layout.flex.horizontal,
}
