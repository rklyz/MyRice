local awful = require "awful"
local gears = require "gears"

-- Script
local title_sc = 'playerctl -i firefox metadata xesam:title' 
local artist_sc = 'playerctl -i firefox metadata xesam:artist'
local length_sc = 'playerctl -i firefox metadata --format "{{duration(position)}}/{{duration(mpris:length)}}"'
local status_sc = 'playerctl -i firefox status'

-- function
local function get_player()
	awful.spawn.easy_async_with_shell(title_sc, function(title)
		awful.spawn.easy_async_with_shell(artist_sc, function(artist)
			awful.spawn.easy_async_with_shell(length_sc, function(length)
				awful.spawn.easy_async_with_shell(status_sc, function(status)
					title = string.gsub(title, "\n", "")
					artist = string.gsub(artist, "\n", "")
					length = string.gsub(length, "\n", "")
					status = string.gsub(status, "\n", "")
					awesome.emit_signal("signal::player", title, artist, length, status)
				end)
			end)
		end)
	end)
end

gears.timer {
	timeout = 5,
	call_now = true,
	autostart = true,
	callback = function()
		get_player()
	end
}
