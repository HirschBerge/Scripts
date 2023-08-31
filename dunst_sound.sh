if [ "$1" == "Spotify" ] || [ "$1" == "discord" ]
then 
	echo ""
else	
	mpv ~/.config/dunst/notification.wav
fi
