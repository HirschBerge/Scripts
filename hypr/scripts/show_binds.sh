#!/usr/bin/env bash
config_file=~/.config/hypr/hyprland.conf

keybinds=$(grep -oP '(?<=bind = ).*' $config_file)
keybinds=$(echo "$keybinds" | sed 's/$mainMod/SUPER/g'|  sed 's/,\([^,]*\)$/ = \1/' | sed 's/, exec//g' | sed 's/^,//g')
rofi -dmenu -replace -p "Keybinds" -config ~/.config/rofi/steam/gamelauncher_4.rasi <<< "$keybinds"
