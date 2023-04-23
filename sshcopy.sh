#!/bin/sh

status=`ping -c1 androssi | awk -F"," '/transmitted/ { print $4 }' |sed -e 's/% packet loss//g' -e 's/ 1/1/g' -e 's/ 0/0/g'`


pullfiles() {
  anilocation="$HOME/Documents/animoos"
  ssh androssi exa -RD $anilocation | grep ":" |sed -e 's/://g' -e 's/ /\\ /g' > ~/.cache/afile.txt  
  anilocation2=`cat ~/.cache/afile.txt | dmenu -fn "MesloLGS L" -l 5 -p "Which anime are you watching?" |sed 's/\/home\/hirschy\/Documents\/animoos\///g'`
  anilocation3=`echo $anilocation/$anilocation2 | sed 's/ /\ /g'`
  echo $anilocation3
  #ssh androssi exa -D "$anilocation3" > ~/.cache/bfile.txt 
  #cat ~/.cache/bfile.txt | dmenu -fn "MesloLGS L" -l 5 -p "Which season?" 
  
}





main() {
  if [[ $status -eq 0 ]]
  then
    echo "Laptop is up."
    pullfiles
  elif [[ $status -eq 100 ]]
  then
    echo "Laptop is down."
  else
    echo "Something broke. shit"
  fi
}

main
