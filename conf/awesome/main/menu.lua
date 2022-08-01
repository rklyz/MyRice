local awful = require "awful"
local wibox = require "wibox"
local gears = require "gears"

local apps = require "main.apps"
local screenshot = require "lib.screenshot"

screenshotMenu = {
	{ "Screenshot Now", function() screenshot.now() end},
	{ "Screenshot Later", function() screenshot.later() end}
}

mainmenu = awful.menu {
	items = {
		{ "Refresh", awesome.restart }, 
		{ "Terminal", apps.terminal },
		{ "Browser", apps.browser },
		{ "File Manager", apps.fileManager },
		{ "Screenshot", screenshotMenu}
	}
}
