local awful = require "awful"
local gears = require "gears"

local old_mpd_song = "Connecting..."
local old_mpd_stat = false

local mpd_song = ""
local mpd_stat = nil

local check_song = function()
	
	script = [[
	mpc current
	]]

	awful.spawn.easy_async_with_shell(
		script,
		function(stdout)
			
			if stdout ~= "" then
				mpd_song = stdout
			else
				mpd_song = "No player detected"
			end
		end
	)
end

local check_paused = function()

	script = [[
	mpc status %state%
	]]

	awful.spawn.easy_async_with_shell(
		script,
		function(stdout)
			
			if stdout == "paused" then
				mpd_stat = false
			else
				mpd_stat = true
				check_song()
			end

			if mpd_song ~= old_mpd_song or mpd_stat ~= old_mpd_stat then
				awesome.emit_signal("signal::mpd", mpd_song, mpd_stat)
				old_mpd_song = mpd_song
				old_mpd_state = mpd_state
			end
		end
	)
end

gears.timer{
	timeout = 3,
	autostart = true,
	call_now = true,
	callback = function()
		check_paused()
	end
}
