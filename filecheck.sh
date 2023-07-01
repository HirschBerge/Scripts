#!/bin/sh
IP='192.168.0.2'

hostup() { #check is host is up
  fping -c1 -t300 $IP 2>/dev/null 1>/dev/null
  if [ "$?" = 0 ]
  then
    host=up
    echo "Up"
  else
    host=down
    echo "Down"
  fi
}

mounted() { #Check if filesystem is mounted
files=$(shopt -s nullglob dotglob; echo /mnt/filessss/*)
if (( ${#files} ))
then
  echo Mounted
  mount=mounted
else
  mount=unmounted
  echo Unmounted
fi
}

if [[ "$host" == up && "$mount" == mounted ]]; #If up and mounted (good)
then
  echo "Do nothing (up)"
elif [[ "$host" == down && "$mount" == mounted ]] #If not up and mounted (bad)
then
  echo "Unmount"
elif [[ "$host" == up && "$mount" == unmounted ]] #if host is up and it's not mounted
then
  echo "Mount"
elif [[ "$host" == down && "$mount" == unmounted ]] #if host is not up and and nothing is mounted
then
  echo "Do nothing (down)"
else
  echo "Script broke."
fi



hostup
mounted
