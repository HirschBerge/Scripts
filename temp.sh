#!/usr/bin/env bash
temp=$(sensors |grep "CPU" | grep "°C" | awk -F"+" '{ print $2 }' |sed -e 's/\.0//g'|grep -Eo '[0-9]{1,4}')
# echo $temp
if [ "$XDG_CURRENT_DESKTOP" == "Hyprland" ]; then
  echo "$temp°C"
else
  if [ -z "$temp" ]; then
    echo "%{F#5D3FD3} $temp°C"
  elif [ "$temp" -ge 80 ]; then
    echo "%{F#FF0000} $temp°C"
  elif [ "$temp" -ge 40 ]; then
    echo "%{F#5D3FD3} $temp°C"
  else
    echo "%{F#00FF00} $temp°C"
  fi
fi
