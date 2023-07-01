#!/bin/bash
SOUND_FILE=/usr/share/sounds/freedesktop/stereo/complete.oga

sudo pacman -Syu
status=$?

[ $status -eq "0" ] && notify-send -t 3000 -u normal "Your system has finished updating successfully!" || notify-send -t 3000 -u critical "Uh oh! Pacman experienced an errors!"

[ -f $SOUND_FILE ] && paplay $SOUND_FILE || notify-send -u critical -i error "Error" "Can't find file /usr/share/sounds/freedesktop/stereo/complete.oga. Settings is located in $(pwd) in file $0"
