#!/usr/bin/env bash

folder="$HOME/Backgrounds/animewide/"

if [ -n "$1" ]; then
  folder="$1"
fi

send_discord_message() {
  local WEBHOOK_URL="https://discord.com/api/webhooks/1085380232908902420/67yS35DSklhRDQyf9r-9om4ragu6rpXykkQeXoXoRpa5ACcCeNftme_QxMnbzdUDhatO"
  local USERNAME="Sexy Surprise"
  local message_content="$1"

  curl -H "Content-Type: application/json" -X POST -d '{
    "content": "'"${message_content}"'",
    "username": "'"${USERNAME}"'"
  }' "${WEBHOOK_URL}"
}



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
  lewd=$((1 + $RANDOM % 100))
  imgwide=$(cat "$HOME/.scripts/background/resourceswide")
  imgnorm=$(cat "$HOME/.scripts/background/resourcesnorm")
  echo "$imgnorm" "$imgwide"
  cp "$imgwide" ~/.config/wallwide.png
  cp "$imgnorm" ~/.config/wallwide2.png
  if [[ $lewd -eq 1 ]]
  then
    /run/wrappers/bin/sudo -u hirschy DISPLAY=:0 DBUS_SESSION_BUS_ADDRESS=unix:path/run/user/1000/bus /etc/profiles/per-user/hirschy/bin/xwallpaper --no-randr --focus /mnt/NAS/Pictures/lewd2.png
    send_discord_message "<@215327353423921159> SURPRISEEEEE" 
  else 
    /run/wrappers/bin/sudo -u hirschy DISPLAY=:0 DBUS_SESSION_BUS_ADDRESS=unix:path/run/user/1000/bus /etc/profiles/per-user/hirschy/bin/xwallpaper --output DP-2 --zoom ~/.config/wallwide.png --output DP-0 --zoom ~/.config/wallwide2.png
  fi
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
