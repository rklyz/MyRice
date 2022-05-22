local beautiful = require "beautiful"
local gfs = require "gears.filesystem"

beautiful.init(gfs.get_configuration_dir() .. "themes/theme.lua")

require "conf.layout"
require "conf.keybind"
require "conf.rules"
require "conf.client"

terminal = "urxvt"
editor = os.getenv("EDITOR") or "vim"
editor_cmd = terminal .. " -e " .. editor
