#!/usr/bin/env bash

folder="$HOME/Backgrounds/animewide/"

if [ -n "$1" ]; then
  folder="$1"
fi

shufflezwide2() {
  for z in $(/etc/profiles/per-user/hirschy/bin/exa -d "$folder"/* | shuf | head -1); do
    echo "$z" > "$HOME/.scripts/background/resourcesnorm"
  done
}

shufflezwide() {
  for z in $(/etc/profiles/per-user/hirschy/bin/exa -d "$folder"/* | shuf | head -1); do
    echo "$z" > "$HOME/.scripts/background/resourceswide"
  done
}

function stopprocess {
   local mypid=$$    # capture this run's pid

   declare pids=($(pgrep -f ${0##*/}))   # get all the pids running this script

   for pid in ${pids[@]/$mypid/}; do   # cycle through all pids except this one
      kill $pid                        # kill the other pids
      sleep 1                          # give time to complete
   done
}

sets_background() {
  lewd=$((1 + $RANDOM % 10))
  imgwide=$(cat "$HOME/.scripts/background/resourceswide")
  imgnorm=$(cat "$HOME/.scripts/background/resourcesnorm")
  echo "$imgnorm" "$imgwide"
  cp "$imgwide" ~/.config/wallwide.png
  cp "$imgnorm" ~/.config/wallwide2.png
  [[ $number -eq 10 ]] && /run/wrappers/bin/sudo -u hirschy DISPLAY=:0 DBUS_SESSION_BUS_ADDRESS=unix:path/run/user/1000/bus /etc/profiles/per-user/hirschy/bin/xwallpaper --no-randr --focus /mnt/NAS/Pictures/lewd2.png || /run/wrappers/bin/sudo -u hirschy DISPLAY=:0 DBUS_SESSION_BUS_ADDRESS=unix:path/run/user/1000/bus /etc/profiles/per-user/hirschy/bin/xwallpaper --output DP-2 --zoom ~/.config/wallwide.png --output DP-0 --zoom ~/.config/wallwide2.png
}

main() {
  stopprocess
  while true; do
    shufflezwide2
    shufflezwide
    sets_background
    # chmod +x -R "$HOME/Backgrounds/*" "$HOME/.scripts/"
    sleep 300
  done
}


sleep 5
main #>/dev/null 2>&1 &
