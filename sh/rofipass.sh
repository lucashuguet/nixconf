#!/usr/bin/env bash

passwords=$(find ~/.password-store/ -iname "*.gpg" | sed "s|$HOME/.password-store/||g" | sed "s/\.gpg//g")

selected=$(rofi -dmenu <<< $passwords)
echo $selected

notify-send "rofipass.sh" "$(pass $1 -c $selected)"
