#!/bin/sh


direct=`exa ~/Pictures | dmenu -i -fn "MeslosLGS NF" -p "What directory would you like to set as the backgrounds?"`
function stopprocess {
	for i in `ps -aux | grep ~/.scripts/background/background.sh |grep "/bin\|sh " |awk '{ print $2 }'`
	do
		echo Killing $i
		sudo kill -9 $i
	done
}

function setback {
	rm -rf ~/Backgrounds/*
	pycp ~/Pictures/$direct/* ~/Backgrounds >/dev/null 2>&1
	notify-send "Setting the Background to $direct"
	stopprocess
	~/.scripts/background/background.sh >/dev/null 2>&1
}

function main {
	setback >/dev/null 2>&1 &
}
main
