local awful = require "awful"

local apps = require "main.apps"
local volume = require "lib.volume"
local brightness = require "lib.brightness"

modkey = "Mod4"
alt = "Mod1"

awful.keyboard.append_global_keybindings({
	awful.key({modkey}, "p", function() awful.spawn(apps.launcher, false) end), -- Rofi
	awful.key({modkey}, "e", function() awful.spawn(apps.fileManager, false) end), -- Rofi
	awful.key({modkey}, "t", function() awful.spawn("feh /home/cleff/timetable.jpg", false) end), -- Rofi
	awful.key({alt}, "c", function() awesome.emit_signal("sidebar::toggle") end), -- Sidebar
	awful.key({alt}, "t", function() awful.titlebar.toggle(client.focus) end), -- Toggle titlebar
  awful.key({modkey}, ".", function() awful.spawn("rofi -modi emoji -show emoji", false) end), -- Show Rofi Emoji Picker
})

-- Volume 
awful.keyboard.append_global_keybindings({
	awful.key({ }, "XF86AudioRaiseVolume", function() volume.increase() end),
	awful.key({ }, "XF86AudioLowerVolume", function() volume.decrease() end),
	awful.key({ }, "XF86AudioMute", function() volume.mute() end)
})

-- Brightness
awful.keyboard.append_global_keybindings({
	awful.key({ }, "XF86MonBrightnessUp", function() brightness.increase() end),
	awful.key({ }, "XF86MonBrightnessDown", function() brightness.decrease() end)
})

awful.keyboard.append_global_keybindings({
  -- Change Volume
  awful.key({ modkey }, "Up", function() awful.util.spawn_with_shell("~/.scripts/check/changevolumeup") end,
            {description = "increase volume", group = "launcher"}),
  awful.key({ modkey }, "Down", function() awful.util.spawn_with_shell("~/.scripts/check/changevolumedown") end,
            {description = "decrease volume", group = "launcher"}),
  -- Change Brightness
  awful.key({ modkey }, "Left", function() awful.util.spawn_with_shell("~/.scripts/check/changebrightnessdown") end,
            {description = "decrease brightness", group = "launcher"}),
  awful.key({ modkey }, "Right", function() awful.util.spawn_with_shell("~/.scripts/check/changebrightnessup") end,
            {description = "increase brightness", group = "launcher"}),
  -- Screenshot
  awful.key({ modkey, "Shift" }, "s", function() awful.util.spawn_with_shell("scrot -s '/home/cleff/Pictures/Screenshots/%d-%m-%Y-%T-screenshot.jpg'") end,
            {description = "take a screenshot", group = "launcher"}),
  -- Powermenu
  awful.key({}, "XF86PowerOff", function() awful.util.spawn_with_shell("/home/cleff/.config/rofi/powermenu/powermenu.sh") end,
            {description = "powermenu", group = "launcher"}),
})
