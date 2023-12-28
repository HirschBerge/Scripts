#!/usr/bin/env bash
config_file=~/.config/hypr/binds.conf

keybinds=$(grep -oP '(?<=bind = ).*' $config_file)
keybinds=$(echo "$keybinds" | sed 's/$mainMod/SUPER/g'|  sed 's/,\([^,]*\)$/ = \1/' | sed 's/, exec//g' | sed 's/^,//g')
rofi -dmenu -replace -p "Keybinds" -config ~/.config/rofi/launchers/type-1/style-3.rasi <<< "$keybinds"
