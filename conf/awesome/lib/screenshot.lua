local awful = require "awful"
local gears = require "gears"
local wibox = require "wibox"
local naughty = require "naughty"
local beautiful = require "beautiful"

local dpi = beautiful.xresources.apply_dpi

----- ScreeenSHOOOT -----

local screenshot = {}

-- Timer 4 delay
local timer = function(time, script)
	local tt = gears.timer {
		timeout = time,
		call_now = false,
		single_shot = true,
		callback = function()
			awful.spawn.with_shell(script)
			naughty.notify {
				title = "Smile!",
				text = "Screenshot saved",
			}
		end
	}

	tt:start()
end

-- Show now 
function screenshot.shot_now()
	local date = os.date("%y-%m-%d_%H:%M:%S")
	local location = "/tmp/" .. date .. ".png"
	local ss_script = [[
	maim | tee /tmp/]] .. date .. [[.png | xclip -selection clipboard -t image/png
	]]

	awful.spawn.with_shell(ss_script)
end

-- Shot 5 sec later..
function screenshot.shot_later()
	local date = os.date("%y-%m-%d_%H:%M:%S")
        local location = "/tmp/" .. date .. ".png"
        local ss_script = [[
        maim | tee /tmp/]] .. date .. [[.png | xclip -selection clipboard -t image/png
        ]]

	timer(5, ss_script)
end

return screenshot
