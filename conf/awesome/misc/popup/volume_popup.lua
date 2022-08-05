local awful = require "awful"
local gears = require "gears"
local beautiful = require "beautiful"

local create_popup = require "misc.popup.popup"

local popup = create_popup(beautiful.fg)

awesome.connect_signal("signal::volume", function(vol, mute)
	vol = tonumber(vol)
	if vol == 0 or mute then
		popup.update("󰸈")
		popup.updateValue(0)
		popup.toggle()
	else
		if vol < 20 then
			popup.update("󰕿")
		elseif vol < 60 then
			popup.update("󰖀")
		else
			popup.update("󰕾")
		end
		popup.updateValue(vol)
		popup.toggle()
	end
end)
