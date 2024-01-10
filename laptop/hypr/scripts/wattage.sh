#!/usr/bin/env bash
notify-send -u normal --icon ~/Pictures/Monogatari/hawt.jpeg "$(cat /sys/class/power_supply/BAT0/power_now | awk '{ printf "%.1f\n", $1 / 1000000 }')W current power draw"
