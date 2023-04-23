#!/bin/sh

mp4=`echo "$1" |sed 's/mkv/mp4/g'`

echo "$mp4, $1"
ffmpeg -i "$1" -vf subtitles="$1" "$mp4"
