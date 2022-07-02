local awful = require "awful"
local gears = require "gears"

local APIKEY = "d31f4205400f56c0f062b4213e717fe1"
local CITY = "1732891"
local UNIT = "metric"
local LANG = "en"

sun_icon = ""
moon_icon = ""
dcloud_icon = "󰖕"
ncloud_icon = "󰼱"
cloud_icon = "󰖐"
rain_icon = "󰖗"
storm_icon = "󰖖"
snow_icon = "󰼶"
mist_icon = ""
bruh_icon = "No icon"

local weather_icons = {
    ["01d"] = { icon = sun_icon },
    ["01n"] = { icon = moon_icon },
    ["02d"] = { icon = dcloud_icon },
    ["02n"] = { icon = ncloud_icon },
    ["03d"] = { icon = cloud_icon },
    ["03n"] = { icon = cloud_icon },
    ["04d"] = { icon = cloud_icon },
    ["04n"] = { icon = cloud_icon },
    ["09d"] = { icon = rain_icon },
    ["09n"] = { icon = rain_icon },
    ["10d"] = { icon = rain_icon },
    ["10n"] = { icon = rain_icon },
    ["11d"] = { icon = storm_icon },
    ["11n"] = { icon = storm_icon },
    ["13d"] = { icon = snow_icon },
    ["13n"] = { icon = snow_icon },
    ["40d"] = { icon = mist_icon },
    ["40n"] = { icon = mist_icon },
    ["50d"] = { icon = mist_icon },
    ["50n"] = { icon = mist_icon },
    ["_"] = { icon = bruh_icon },
}

local get_weather = function()

	local script = [[
	URL="api.openweathermap.org/data/2.5/weather?appid=]] .. APIKEY .. 
	[[&units=]] .. UNIT .. 
	[[&lang=]] .. LANG .. 
	[[&id=]] .. CITY .. 
	[["

	OUTPUT=$(curl -s $URL)

	if [ ! -z '$OUTPUT' ]; then
	        TEMP=$(echo $OUTPUT | jq ".main.temp" | cut -d "." -f 1)
       		DESC=$(echo $OUTPUT | jq -r ".weather[].description" | head -1)
       		ICON=$(echo $OUTPUT | jq -r ".weather[].icon")

        	echo "$ICON|$DESC|$TEMP"
	else
        	echo "No data.."
	fi
	]]

	awful.spawn.easy_async_with_shell(script,
		function(stdout)
			local i = string.sub(stdout, 1, 3)
			local temp = stdout:match(".+[|].+[|](.+)")
			local how  = stdout:match(".+[|](.+)[|].+")

			temp = string.gsub(temp, "\n", "") -- Remove New line (ugh, i hate to do this)
			local icon = weather_icons[i].icon

			awesome.emit_signal("signal::weather", temp, icon, how)
		end
	)
end

gears.timer {
	timeout = 1200,
	autostart = true,
	call_now = true,
	callback = function()
		get_weather()
	end
}
