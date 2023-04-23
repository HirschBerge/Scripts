#!/bin/sh
basis="`exa|dmenu -fn "MesloLGS NF" -l 5 -i`"
#something="`$basis | sed 's/ /\\ /g'`"
#changed= `echo $basis| sed 's/(.*)//g' | sed 's/\[.*\]//g' | awk -F'-' '{ print $1 $2 ".mp3"}' | sed 's/. \.mp4/.mp3/g'`

#echo -e "basis $basis"
changed=`echo $basis | sed 's/(.*)//g' | sed 's/\[.*\]//g' | awk -F'-' '{ print $1 $2 ".mp3"}' | sed 's/\ *\./\./g'| sed 's/  / /g' | sed 's/://g' |sed 's/?//g'`
echo "ffmpeg -i "$basis" -b:a 320k -vn \"$changed\""
ffmpeg -i "$basis" -b:a 320k -vn "$HOME/Music/Audio/$changed"
