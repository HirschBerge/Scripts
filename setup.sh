#!/bin/sh

NoColor="\033[0m"
Red='\033[0;31m'          # Red
Black='\033[0;30m'        # Black
Green='\033[0;32m'        # Green
Yellow='\033[0;33m'       # Yellow
Blue='\033[0;34m'         # Blue
Purple='\033[0;35m'       # Purple
Cyan='\033[0;36m'         # Cyan
White='\033[0;37m'        # White


TARGET="$HOME/.config/"

[[ -d "$TARGET" ]] && printf "${Green}[+]${Blue} Configs folder exists. Propigating...${NoColor}\n" || mkdir $TARGET
sleep 1
printf "${Green}[+] ${Blue}Copying program config files to ${Yellow}~/.config${NoColor}\n"
rsync -rahi  --exclude ".git/" --exclude "nixos/" --exclude "bin" --exclude "setup.sh" $PWD/ $TARGET >/dev/null
printf "${Green}[+] ${Blue}Copying NixOS files to ${Purple}/etc/nixos${NoColor}\n"
sleep 1
TARGET="/etc/nixos/"
sudo rsync -rahi ./nixos/ $TARGET >/dev/null

printf "${Green}[+] ${Blue}Allow Mone-Manager${NoColor}"
sudo nix-channel --add https://github.com/nix-community/home-manager/archive/master.tar.gz home-manager
sudo nix-channel --update
sudo nix-channel --add https://github.com/nix-community/home-manager/archive/release-23.05.tar.gz home-manager
sudo nix-channel --update
printf "${Green}Complete!${NoColor}"