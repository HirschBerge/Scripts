#!/usr/bin/env bash
if [ "$1" == "Spotify" ] || [ "$1" == "discord" ]
then 
	echo "test"
else 
	mpv ~/.config/dunst/notification.wav
fi
#dunstify "$1"
