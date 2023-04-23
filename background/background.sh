#!/bin/sh
function shufflez {
	for z in `exa -d $HOME/Backgrounds/* | shuf`
	do
		echo $z >>  $HOME/.scripts/background/resources
	done
}


#Actual Script starts here
#input= "$HOME/.scripts/background/resources"
function sets_background_loop {
	while IFS= read -r line
	do
		[ ! -z "$line" ] && cp "$line" ~/.config/wall.png
		xwallpaper --zoom ~/.config/wall.png
	#	echo $line
		sleep 300
	done < $HOME/.scripts/background/resources
}


function stopprocess {
	for i in `ps -aux | grep ~/.scripts/background/ | grep "/bin\|sh " | awk '{ print $2 }'`
	do
		echo Killing $i
		sudo kill -9 $i
	done
}

function main {
	rm -f $HOME/.scripts/background/resources
	shufflez
	sets_background_loop
	chmod +x $HOME/Backgrounds/* $HOME/.scripts/*
	stopprocess
	sh $HOME/.scripts/background/background.sh
}
main >/dev/null 2>&1 &
