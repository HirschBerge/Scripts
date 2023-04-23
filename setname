#!/bin/bash
echo -e "Custom name: "
read -r name
exa -1 |grep -v OLD |grep -v NEW > OLD
exa -1 |grep Mp4up | awk '{ print $1 ".mp4"}' | sed "s/^/$name /g"> NEW
cat OLD NEW

sleep 3
while IFS= read -r old <&3 && IFS= read -r new <&4; do
	mv -i -- "$old" "$new"
done 3< OLD 4< NEW
rm NEW OLD
exa -l
