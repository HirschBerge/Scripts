#!/bin/sh

currentlyplaying=`xsel -b`


mpv --fs=yes --ytdl-format="bestvideo[ext=mp4][height<=?1080]+bestaudio[ext=m4a]" "$currentlyplaying" > /dev/null 2>&1 &
