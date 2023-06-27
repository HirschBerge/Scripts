#!/bin/bash
bin_path='/usr/local/bin'
chmod +x -R ~/.scripts/
sudo ln -s ~/.scripts/animewget.py "$bin_path/animewget"
sudo ln -s ~/.scripts/mangadex.py "$bin_path/mdex"
sudo ln -s ~/.scripts/mounting "$bin_path/mounting"
sudo ln -s ~/.scripts/yt.sh "$bin_path/yt" 
sudo ln -s ~/.scripts/web.sh "$bin_path/web" 
sudo ln -s ~/.scripts/dudu.sh "$bin_path/dudu"
sudo ln -s ~/.scripts/pacUpdate.sh "$bin_path/pacUpdate"