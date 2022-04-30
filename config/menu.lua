local gears = require("gears")
local awful = require("awful")
local beautiful = require("beautiful")
local gfs = require("gears.filesystem")
require("awful.autofocus")

beautiful.init(gfs.get_configuration_dir() .. "theme/theme.lua")

----- Some Settings here -----

modkey = "Mod4"

terminal = "urxvt"
editor = "vim"
editor_cmd = terminal .. " -e " .. editor


----- Autostart some programs -----

local autostart_apps = {
	"xset -b",
	"picom --config ~/.config/picom/*",
}

for app = 1, #autostart_apps do
	awful.spawn.with_shell(autostart_apps[app])
end


----- Menu -----

powercontrol = {
	{ "Poweroff", terminal .. " poweroff" },
	{ "Reboot", terminal .. " reboot" },
}

apps_menu = {
	{ "Firefox", "firefox" },
	{ "Discord", "discord" },
}

mymainmenu = awful.menu({ items = {
        { "Apps", apps_menu },
        { "PowerControl", powercontrol },
        { "Terminal", terminal },
        },
})
