local gears = require("gears")
local awful = require("awful")
local beautiful = require("beautiful")
local gfs = require("gears.filesystem")
require("awful.autofocus")

----- Menu -----


powercontrol = {
	{ "Poweroff", terminal .. " poweroff" },
	{ "Reboot", terminal .. " reboot" },
}

apps_menu = {
	{ "Firefox", "firefox" },
	{ "Discord", "discord" },
}

mainmenu = awful.menu({ 
	items = {
		{ "Apps", apps_menu },
		{ "PowerControl", powercontrol },
		{ "Terminal", terminal },
	},
})

