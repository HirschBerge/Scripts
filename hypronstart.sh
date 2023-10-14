#!/usr/bin/env bash
waybar_init (){  
  ps aux |grep [w]aybar  |grep -v "vim" | awk '{ print $2 }' |xargs kill
  sleep 1
  waybar
}
swww_init (){
  swww init
  # ~/.scripts/background/cron.sh ~/Pictures/Sci-Fi/ #Issues with this, kinda hacking, but oh well
}
dunst_init (){
  dunst
}

main (){
  waybar_init
  swww_init
  dunst_init
}
main
