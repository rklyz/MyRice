local awful = require "awful"
local wibox = require "wibox"
local gears = require "gears"

local apps = require "main.apps"
local screenshot = require "lib.screenshot"

screenshotMenu = {
	{ "Screenshot Now", function() screenshot.now() end},
	{ "Screenshot Later", function() screenshot.later() end}
}

powerMenu = {
	{ "Poweroff", function() awful.spawn("poweroff", false) end},
	{ "Reboot", function() awful.spawn("reboot", false) end}
}

mainmenu = awful.menu {
	items = {
		{ "Refresh", awesome.restart }, 
		{ "Terminal", apps.terminal },
		{ "Browser", apps.browser },
		{ "File Manager", apps.fileManager },
		{ "Screenshot", screenshotMenu },
		{ "Power Options", powerMenu }
	}
}

mainmenu.wibox.shape = function(cr,w,h) 
	gears.shape.rounded_rect(cr,w,h,8)
end
