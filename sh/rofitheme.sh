#!/usr/bin/env bash

file=$(find ~/Pictures/wallpapers/ -name '*.png' -exec basename {} \; | sed "s/.png\$//g" | rofi -dmenu)

if [ $? == 1 ]; then	
  exit 0
fi

convert_rgba() {
    color="$1"
    r=$((16#${color:1:2}))
    g=$((16#${color:3:2}))
    b=$((16#${color:5:2}))
    echo "rgba($r, $g, $b, 100%)"
}

clamp() {
    n="$1"
    smallest="$2"
    largest="$3"
    echo $(($n < $smallest ? $smallest : ($n > $largest ? $largest : $n)))
}

twolen() {
    hexa="$1"
    if [ ${#hexa} -eq 1 ]; then
        echo "0$hexa"
    else
        echo "$hexa"
    fi
}

light_color() {
    color="$1"
    if [ ${#color} -ne 7 ]; then
        exit 1
    fi
    r="${color:1:2}"
    g="${color:3:2}"
    b="${color:5:2}"

    rgb=($(printf '%d ' "0x$r" "0x$g" "0x$b"))
    light=($(clamp $((rgb[0] * 130 / 100)) 0 255) $(clamp $((rgb[1] * 130 / 100)) 0 255) $(clamp $((rgb[2] * 130 / 100)) 0 255))

    echo "#$(twolen $(printf '%x' ${light[0]}))$(twolen $(printf '%x' ${light[1]}))$(twolen $(printf '%x' ${light[2]}))"
}

wal -qntes -i ~/Pictures/wallpapers/$file.png

source ~/.cache/wal/colors.sh

swww img $wallpaper -t none

black=$color0
red=$color1
green=$color2
yellow=$color3
blue=$color4
magenta=$color5
cyan=$color6
white=$color7

lblack=$color8
lred=$(light_color $red)
lgreen=$(light_color $green)
lyellow=$(light_color $yellow)
lblue=$(light_color $blue)
lmagenta=$(light_color $magenta)
lcyan=$(light_color $cyan)
lwhite=$(light_color $white)

lforeground=$white
lbackground=$color2

colors_path=~/.config/colors

alacritty=$colors_path/alacritty.toml
qutebrowser=$colors_path/qutebrowser.yml
rofi=$colors_path/rofi.rasi
hyprland=$colors_path/hyprland.conf
waybar=$colors_path/waybar.css
dunst=$colors_path/dunst.toml
aura=$colors_path/aura.txt
kitty=$colors_path/kitty.conf

dunstc=~/.config/dunst/config.toml
dunstrc=~/.config/dunst/dunstrc

rm $alacritty
echo "[colors.primary]" | tee -a $alacritty
echo "background = '$background'" | tee -a $alacritty
echo "foreground = '$foreground'" | tee -a $alacritty
echo "[colors.normal]" | tee -a $alacritty
echo "black = '$black'" | tee -a $alacritty
echo "red = '$red'" | tee -a $alacritty
echo "green = '$green'" | tee -a $alacritty
echo "yellow = '$yellow'" | tee -a $alacritty
echo "blue = '$blue'" | tee -a $alacritty
echo "magenta = '$magenta'" | tee -a $alacritty
echo "cyan = '$cyan'" | tee -a $alacritty
echo "white = '$white'" | tee -a $alacritty
echo "[colors.bright]" | tee -a $alacritty
echo "black = '$lblack'" | tee -a $alacritty
echo "red = '$lred'" | tee -a $alacritty
echo "green = '$lgreen'" | tee -a $alacritty
echo "yellow = '$lyellow'" | tee -a $alacritty
echo "blue = '$lblue'" | tee -a $alacritty
echo "magenta = '$lmagenta'" | tee -a $alacritty
echo "cyan = '$lcyan'" | tee -a $alacritty
echo "white = '$lwhite'" | tee -a $alacritty

rm $qutebrowser
echo "colors:" | tee -a $qutebrowser
echo "  primary:" | tee -a $qutebrowser
echo "    background: '$background'" | tee -a $qutebrowser
echo "    foreground: '$foreground'" | tee -a $qutebrowser
echo "  normal:" | tee -a $qutebrowser
echo "    black: '$black'" | tee -a $qutebrowser
echo "    red: '$red'" | tee -a $qutebrowser
echo "    green: '$green'" | tee -a $qutebrowser
echo "    yellow: '$yellow'" | tee -a $qutebrowser
echo "    blue: '$blue'" | tee -a $qutebrowser
echo "    magenta: '$magenta'" | tee -a $qutebrowser
echo "    cyan: '$cyan'" | tee -a $qutebrowser
echo "    white: '$white'" | tee -a $qutebrowser
echo "  bright:" | tee -a $qutebrowser
echo "    black: '$lblack'" | tee -a $qutebrowser
echo "    red: '$lred'" | tee -a $qutebrowser
echo "    green: '$lgreen'" | tee -a $qutebrowser
echo "    yellow: '$lyellow'" | tee -a $qutebrowser
echo "    blue: '$lblue'" | tee -a $qutebrowser
echo "    magenta: '$lmagenta'" | tee -a $qutebrowser
echo "    cyan: '$lcyan'" | tee -a $qutebrowser
echo "    white: '$lwhite'" | tee -a $qutebrowser

rm $rofi
echo "* {" | tee -a $rofi
echo "    red: $(convert_rgba $red);" | tee -a $rofi
echo "    blue: $(convert_rgba $blue);" | tee -a $rofi
echo "    foreground: $(convert_rgba $foreground);" | tee -a $rofi
echo "    background: $(convert_rgba $background);" | tee -a $rofi
echo "    lightfg: $(convert_rgba $lbackground);" | tee -a $rofi
echo "    lightbg: $(convert_rgba $background);" | tee -a $rofi
echo "}" | tee -a $rofi

rm $hyprland
echo "general {" | tee -a $hyprland
echo "    col.active_border = rgba(${lforeground:1}ee)" | tee -a $hyprland
echo "    col.inactive_border = rgba(${lbackground:1}ee)" | tee -a $hyprland
echo "}" | tee -a $hyprland
echo "decoration {" | tee -a $hyprland
echo "    col.shadow = rgba(${background:1}ee)" | tee -a $hyprland
echo "}" | tee -a $hyprland

rm $waybar
echo "@define-color foreground $foreground;" | tee -a $waybar
echo "@define-color background $background;" | tee -a $waybar
echo "@define-color red $red;" | tee -a $waybar
echo "@define-color green $green;" | tee -a $waybar
echo "@define-color yellow $yellow;" | tee -a $waybar
echo "@define-color blue $blue;" | tee -a $waybar
echo "@define-color magenta $magenta;" | tee -a $waybar
echo "@define-color cyan $cyan;" | tee -a $waybar
echo "@define-color white $white;" | tee -a $waybar
echo "@define-color lblack $lblack;" | tee -a $waybar

rm $dunst
echo "[global]" | tee -a $dunst
echo "    frame_color = \"$lforeground\"" | tee -a $dunst
echo "[urgency_normal]" | tee -a $dunst
echo "    background = \"$background\"" | tee -a $dunst
echo "    foreground = \"$foreground\"" | tee -a $dunst

rm $dunstrc
cat $dunst | tee -a $dunstrc
cat $dunstc | tee -a $dunstrc

rm $aura
echo $(echo $red | cut -c2-) | tee -a $aura

rm $kitty
echo "foreground  $foreground" | tee -a $kitty
echo "background  $background" | tee -a $kitty
echo "color0      $black" | tee -a $kitty
echo "color8      $lblack" | tee -a $kitty
echo "color1      $red" | tee -a $kitty
echo "color9      $lred" | tee -a $kitty
echo "color2      $green" | tee -a $kitty
echo "color10     $lgreen" | tee -a $kitty
echo "color3      $yellow" | tee -a $kitty
echo "color11     $lyellow" | tee -a $kitty
echo "color4      $blue" | tee -a $kitty
echo "color12     $lblue" | tee -a $kitty
echo "color5      $magenta" | tee -a $kitty
echo "color13     $lmagenta" | tee -a $kitty
echo "color6      $cyan" | tee -a $kitty
echo "color14     $lcyan" | tee -a $kitty
echo "color7      $white" | tee -a $kitty
echo "color15     $lwhite" | tee -a $kitty

# kitty @ set-colors -a "~/.config/colors/kitty.conf"

pkill waybar
pkill dunst

waybar &
dunst &