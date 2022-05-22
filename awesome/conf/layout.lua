local awful = require "awful"
-- local bling

local l = awful.layout.suit

awful.layout.layouts = {
	l.floating,
	l.tile,
	l.tile.bottom,
}
