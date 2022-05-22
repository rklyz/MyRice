xrdb -merge $HOME/.Xresources &
bash $HOME/.local/bin/mouseaccel.sh

mpd &

playerctld daemon &

#sxhkd -c $HOME/.config/berry/sxhkdrc &

exec awesome
