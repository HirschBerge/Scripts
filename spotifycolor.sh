#!/bin/sh

theme=`exa ~/.config/spicetify-themes |dmenu -fn "MesloLGS NF" -l 10 -p "Choose a Spotify Theme"`
echo $theme
spicetify config current_theme $theme
notify-send "Setting Spotify theme to $theme"
sleep 1
notify-send "Restarting Spotify..."
sleep 2
sudo chmod 775 /opt/spotify
spicetify apply
