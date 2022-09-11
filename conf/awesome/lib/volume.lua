local awful = require "awful"
local gears = require "gears"
local wibox = require "wibox"
local beautiful = require "beautiful"
local dpi = beautiful.xresources.apply_dpi

local volume = {}

-- Popup
----------

volume.popup = wibox {
	visible = false,
	ontop = true,
	width = dpi(300),
	height = dpi(70),
	bg = beautiful.transparent
}

awful.placement.bottom(volume.popup, { margins = {bottom = dpi(100)}})

-- Popup Widget
-----------------

local indicator = wibox.widget {
	background_color = beautiful.bg,
	color = beautiful.blue,
	shape = function(cr,w,h) gears.shape.rounded_rect(cr,w,h,8) end,
	max_value = 100,
	widget = wibox.widget.progressbar,
}

volume.popup : setup {
	indicator,
	{
		{
			font = "Roboto 24",
			align = "left",
			markup = "<span foreground='"..beautiful.fg.."'>󰕾</span>",
			widget = wibox.widget.textbox,
		},
		margins = {left = dpi(20)},
		widget = wibox.container.margin,
	},
	layout = wibox.layout.stack,
}

volume.lifespan = gears.timer {
	timeout = 1,
	call_now = false,
	autostart = false,
	single_shot = true,
	callback = function() 
		volume.popup.visible = false
	end
}

-- Get Vol
function volume.get_vol()
       	script = 'pamixer --get-volume'
	script2 = 'pamixer --get-mute'
       	awful.spawn.easy_async_with_shell(script, function(vol)
		awful.spawn.easy_async_with_shell(script2, function(is_mute)
			if is_mute:match("true") then muted = true else
				muted = false
			end

			if muted then indicator.color = beautiful.red else
				indicator.color = beautiful.blue
			end
	        	vol = tonumber(vol:match("(%d+)"))
       		 	indicator.value = tonumber(vol)
		end)
       end)
end

function volume.changed()
	volume.popup.visible = true
	if not volume.popup.visible then volume.lifespan:start() else
		volume.lifespan:again()
	end
end

-- Control Room
-----------------

volume.increase = function()
	local script = [[
	pamixer -i 3
	]]

	awful.spawn(script, false)
	volume.get_vol()
	volume.changed()
end

volume.decrease = function()
	local script = [[
	pamixer -d 3
	]]

	awful.spawn(script, false)
	volume.get_vol()
	volume.changed()
end

volume.mute = function()
	local script = [[
	pamixer -t
	]]

	awful.spawn(script, false)
	volume.get_vol()
	volume.changed()
end

return volume
