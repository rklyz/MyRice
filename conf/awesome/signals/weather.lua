local awful = require "awful"
local gears = require "gears"

local city = "" -- Ex. London or Salt+Lake+City

local get_weather = function()
  local script = [[
    bash -c "$HOME/.config/awesome/signals/weather_script.sh ]] .. city.. [["
  ]]

	awful.spawn.easy_async_with_shell(script, function(stdout)
		local weather = stdout:match("(.+):")
		local feels_like = stdout:match(".+[:](.+)")
		awesome.emit_signal('signal::weather', weather, feels_like)
	end)
end

gears.timer {
	timeout = 1200,
	call_now = true,
	autostart = true,
	callback = function()
		get_weather()
	end
}
