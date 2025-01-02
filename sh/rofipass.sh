#!/usr/bin/env bash

passwords=$(find ~/.password-store/ -iname "*.gpg" | sed "s|$HOME/.password-store/||g" | sed "s/\.gpg//g")

selected=$(rofi -i -dmenu <<< $passwords)

if [[ $? -eq 0 ]]; then
  echo $selected
else
  exit 1
fi

notify-send "rofipass.sh" "$(pass $1 -c $selected)"
