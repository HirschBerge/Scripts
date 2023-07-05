#!/usr/bin/env bash

for i in */; 
do 
	fixed=$(echo $i |sed 's/\///g')
	[[ "$fixed" = "nixos" ]] || echo "Copying $HOME/.config/$i to $PWD"
	[[ "$fixed" = "nixos" ]] || rsync -rah --progress -i "$HOME/.config/$i" "./$i" >/dev/null
done
rsync -rah --progress -i /etc/nixos/* nixos/