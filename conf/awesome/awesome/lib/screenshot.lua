local awful = require "awful"
local gears = require "gears"
local naughty = require "naughty"

local notify = require "misc.notif.notify"

local screenshot = {}

screenshot.now = function()
	local time = os.date("%y-%m-%d_%H:%M:%S")
	local location = "/tmp/"..time..".png"

	local script = [[
	maim | tee ]]..location..[[ | xclip -selection clipboard -t image/png
	]]

	awful.spawn.with_shell(script)
	notify.screenshot(location)
end

screenshot.later = function()
	local time = os.date("%y-%m-%d_%H:%M:%S")
	local location = "/tmp/"..time..".png"

	local script = [[
        maim -d 5 | tee ]]..location..[[ | xclip -selection clipboard -t image/png
	]]

	awful.spawn.with_shell(script)

	gears.timer {
		timeout = 6,
		autostart = false,
		call_now = false,
		single_shot = true,
		callback = function()
			notify.screenshot(location)
		end
	}:start()

end

return screenshot
