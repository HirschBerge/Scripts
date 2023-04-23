#!/bin/sh

exa -1RD ~/U32/Transmission ~/Music ~/Videos |grep -v ^$ |grep  home | dmenu -fn "MeslosLGS NF" -i -l 5 | sed 's|[:,]||g' > pd.list
exa -1 "`cat pd.list`"| shuf >music.list
#exa -1 "$1"> music.list
input="music.list"
while IFS= read -r line
do
  echo "`cat pd.list`/$line"
  mpv --no-audio-display --fs=yes "`cat pd.list`/$line"
done < "$input"
rm -rf music.list pd.list


