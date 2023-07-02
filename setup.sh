#!/bin/sh
bin_path='/home/hirschy/.local/bin'
chmod +x -R ~/.scripts/
sudo ln -s ~/.scripts/animewget.py "$bin_path/animewget"
sudo ln -s ~/.scripts/mangadex.py "$bin_path/mdex"
sudo ln -s ~/.scripts/mounting "$bin_path/mounting"
sudo ln -s ~/.scripts/yt.sh "$bin_path/yt" 
sudo ln -s ~/.scripts/web.sh "$bin_path/web" 
sudo ln -s ~/.scripts/dudu.sh "$bin_path/dudu"
sudo ln -s ~/.scripts/pacUpdate.sh "$bin_path/pacUpdate"

echo "Allow Mone-Manager"
sudo nix-channel --add https://github.com/nix-community/home-manager/archive/master.tar.gz home-manager
sudo nix-channel --update
sudo nix-channel --add https://github.com/nix-community/home-manager/archive/release-23.05.tar.gz home-manager
sudo nix-channel --update
