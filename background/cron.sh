#!/bin/sh

folder="$HOME/Backgrounds/animewide/"

if [ -n "$1" ]; then
  folder="$1"
fi

shufflezwide2() {
  for z in $(exa -d "$folder"/* | shuf | head -1); do
    echo "$z" > "$HOME/.scripts/background/resourcesnorm"
  done
}

shufflezwide() {
  for z in $(exa -d "$folder"/* | shuf | head -1); do
    echo "$z" > "$HOME/.scripts/background/resourceswide"
  done
}

function stopprocess {
  for i in $(ps -aux | grep .scripts/background/cron.sh | grep "/bin\|sh " | awk '{ print $2 }'); do
    echo Killing $i
    sudo kill -9 $i
  done
}

sets_background() {
  imgwide=$(cat "$HOME/.scripts/background/resourceswide")
  imgnorm=$(cat "$HOME/.scripts/background/resourcesnorm")
  echo "$imgnorm" "$imgwide"
  cp "$imgwide" ~/.config/wallwide.png
  cp "$imgnorm" ~/.config/wallwide2.png
  sudo -u hirschy DISPLAY=:0 DBUS_SESSION_BUS_ADDRESS=unix:path/run/user/1000/bus xwallpaper --output DP-2 --zoom ~/.config/wallwide.png --output DP-0 --zoom ~/.config/wallwide2.png
}

main() {
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
