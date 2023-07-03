#!/usr/bin/env bash

vol_device=$(wpctl status |grep Sinks -m1 -A 13 |grep -i "vol:" -m 1 |awk -F"*" '{ print $2 }' |awk '{ print $1 }' |sed 's/\.//g')
echo $1
wpctl set-volume $vol_device "$1"
