local apps = {
	terminal = "alacritty",
	--launcher = "rofi -show drun",
	launcher = os.getenv( "HOME" ) .. "/.config/rofi/launcher/launcher.sh",
	browser = "firefox",
	picture = "feh",
	fileManager = "thunar",
}

return apps
