#!/bin/bash
bin_path='/usr/local/bin'
chmod +x -R ~/.scripts/
sudo ln -s $PWD/animewget.py "$bin_path/animewget"
sudo ln -s $PWD/mangadex.py "$bin_path/mdex"
sudo ln -s $PWD/mounting "$bin_path/mounting"
sudo ln -s $PWD/yt.sh "$bin_path/yt" 
sudo ln -s $PWD/web.sh "$bin_path/web" 
sudo ln -s $PWD/dudu.sh "$bin_path/dudu"
sudo ln -s $PWD/pacUpdate.sh "$bin_path/pacUpdate"