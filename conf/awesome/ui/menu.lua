local gears = require("gears")
local awful = require("awful")
local wibox = require "wibox"
local beautiful = require("beautiful")
local naughty = require "naughty"
local gfs = require("gears.filesystem")
require("awful.autofocus")

local scr = function()
        local time = os.date("%y-%m-%d_%H:%M:%S")
	local location = "/tmp/" .. time .. ".png"
        local script = [[
        maim | tee /tmp/]] .. time .. [[.png | xclip -selection clipboard -t image/png
	notify-send -i ]] .. location .. [[ "Kashott!" "Screenshot copied to clipboard"
        ]]

        awful.spawn.with_shell(script)
end

----- Menu -----

mainmenu = awful.menu({ 
	items = {
		{ "Refresh", awesome.restart }, 
		{ "Terminal", terminal },
		{ "Browser", browser },
		{ "File Manager", fileManager },
		{ "Screenshot", function() 
			scr()
		end },
		{ "Power", function()
			awesome.emit_signal("ui::powermenu:open")
		end},
	},
})

