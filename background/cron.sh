#!/usr/bin/env bash

folder="$HOME/Backgrounds/animewide/"

sleep_time=300

if [ -n "$2" ]; then
  sleep_time="$2"
fi

if [ -n "$1" ]; then
  folder="$1"
fi


echo $folder
send_discord_messae() {
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
  export SWWW_TRANSITION_FPS=120
  export SWWW_TRANSITION_STEP=2
  if [[ $lewd -eq 1 ]]
  then
    /run/current-system/sw/bin/swww img /mnt/NAS/Pictures/lewd2.png
    send_discord_message "<@215327353423921159> SURPRISEEEEE" 
  else 
    $(which swww) img -t random -o eDP-1 ~/.config/wallwide.png 
    # $(which swww) img -t random -o DP-2 ~/.config/wallwide2.png 
  fi
}

main() {
  stopprocess
  while true; do
    shufflezwide2
    shufflezwide
    sets_background
    # chmod +x -R "$HOME/Backgrounds/*" "$HOME/.scripts/"
    sleep $sleep_time
  done
}


main #>/dev/null 2>&1 &
