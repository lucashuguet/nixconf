#!/usr/bin/env bash

xrandr --output eDP-1 --mode 1920x1080 --rate 60 &
picom &

source ~/.cache/wal/colors.sh
feh --no-fehbg --bg-fill $wallpaper &

# disable screen saving
xset s off;
xset -dpms;
xset s noblank;

# fix cursor theme
xsetroot -cursor_name left_ptr
