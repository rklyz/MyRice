local awful = require "awful"
local gears = require "gears"

local old_cur_song = "Reconnect"
local old_cur_artist = "Reconnect"
local old_cur_stat = false

local check_song = function()
	
	local script = [[
	playerctl -p spotify metadata --format "{{title}}|{{artist}}"
	]]

	local updt_song = awful.spawn.easy_async_with_shell(
		script,
		function(stdout)
			local cur_song = stdout
			local cur_artist = ""
			local cur_stat = false

			if cur_song ~= "" then
				cur_song = stdout:match("(.+)[|]")
				cur_artist = stdout:match(".+[|](.+)")
				cur_stat = true
			else
				cur_song = "No player detected"
				cur_artist = ""
				cur_stat = false
			end

			if cur_song ~= old_cur_song then
				awesome.emit_signal("signal::song", cur_song, cur_artist, cur_stat)
				old_cur_song = cur_song
				old_cur_artist = cur_artist
				old_cur_stat = cur_stat
			end	
		end
	)
end

check_song()

gears.timer{
	timeout = 3,
	autostart = true,
	call_now = true,
	callback = function() 
		check_song()
	end,
}
