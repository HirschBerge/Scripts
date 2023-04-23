#!/bin/sh
function questions {
	sub=`read -p| dmenu -fn "MeslosLGS NF" -p "What SubReddit would you like to download from?"`

	sorting=`echo -e "top\nnew\nhot\nrising\ncontroversial\nrelevance" | dmenu -i -l 10 -fn "MeslosLGS NF" -p "How would you like to sort this Sub?"`

	time=`echo -e "month\nhour\nday\nweek\nyear\nall" | dmenu -i -l 10 -fn "MeslosLGS NF" -p "How recent should the results be?"`

	limit=`read -p |dmenu -fn "MeslosLGS NF" -p "How many posts would you like to download? (Please enter a number)"`

	direct=`read -p | dmenu -fn "MeslosLGS NF" -p "What directory would you like to store these in? (~/ Assumed)"`

	search="`echo -e "Yes\nNo" | dmenu -i -fn "MeslosLGS NF" -p "Would you like to search for a keyword?"`"
}

function stopprocess {
	for i in `ps -aux | grep ~/.scripts/background/background.sh |grep "/bin\|sh " |awk '{ print $2 }'`
	do
		echo Killing $i
		sudo kill -9 $i
	done
}

function run {
	if [ $search == 'Yes' ]
	then
		keyword=`read -p | dmenu -fn "MeslosLGS NF" -p "What Keyword are you searching for?"`
		/usr/local/bin/redditdl --search $keyword --subreddit $sub --sort $sorting --limit $limit --directory /home/$USER/$direct --quit
	else
		/usr/local/bin/redditdl --subreddit $sub --sort $sorting --limit $limit --directory /home/$USER/$direct --quit
	fi
}

function movearound {
	mv /home/$USER/$direct/$sub/* /home/$USER/$direct/
	rm -rf /home/$USER/$direct/$sub
	rm -rf /home/$USER/$direct/LOG_FILES
	rm /home/$USER/$direct/*.md

}

function converting {
	cd /home/$USER/$direct/
	echo "Converting all JPG to PNG, this may take a litte while."
	mogrify -format png *.jpg
	rm *.jpg
	cd -
}

function talking {
	if [ $search == 'Yes' ]
	then
		echo -e "Downloading pictures from r/$sub!"
		echo -e "Settings:\n\tLooking for up to $limit $keyword\n\tand sorting by \"$sorting\" in the last \"$time\".\n\tThese are being saved in ~/$direct."
	else
		echo -e "Downloading pictures from r/$sub!"
		echo -e "Settings:\n\tSorting by \"$sorting\" in the last \"$time\".\n\tThese are being saved in ~/$direct."
	fi
}

function setback {
	backy=`echo -e "Yes\nNo" |dmenu -i -fn "MeslosLGS NF" -p "Would you like to set this as the background rotation?"`
	if [ $backy == 'Yes' ]
	then
		rm ~/Backgrounds/*
		pycp /home/$USER/$direct/* /home/$USER/Backgrounds/
		echo "Setting the Background."
		stopprocess
	else
		:
	fi
}


questions 2>/dev/null
run >/dev/null 2>&1
talking
movearound 2>/dev/null
converting 2>/dev/null
setback
