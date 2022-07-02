xrdb -merge $HOME/.Xresources &
bash $HOME/.local/bin/mouseaccel.sh &


$HOME/go/bin/mpd-mpris -host localhost &

playerctld daemon &

#sxhkd -c $HOME/.config/berry/sxhkdrc &

xset -b &

exec awesome
