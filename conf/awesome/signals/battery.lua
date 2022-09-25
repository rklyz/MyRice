local awful = require "awful"
local gears = require "gears"
local beautiful = require "beautiful"

local have_battery = [[
	bash -c '
		cat /sys/class/power_supply/BAT?/capacity 2>/dev/null | head -1
	'
]]

local bat_value
local bat_desc

local function get_bat()
	awful.spawn.easy_async(have_battery, function(stdout)
		if not stdout:match("%d+") then
			bat_value = 0
			bat_desc = "No Battery"
			awesome.emit_signal("signal::bat", bat_value, bat_desc)
		else
			bat_value = tonumber(stdout)
			bat_desc = bat_value.."% left"
			awesome.emit_signal("signal::bat", bat_value, bat_desc)
		end
	end)
end

gears.timer {
	timeout = 5,
	call_now = true,
	autostart = true,
	callback = function()
		get_bat()
	end
}
