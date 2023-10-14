#!/usr/bin/env bash

opt1=$(shuf -n 1 -e ~/Pictures/Monogatari/*)
opt2=$(shuf -n 1 -e ~/Pictures/Monogatari/*)

/run/current-system/sw/bin/swww img -t random -o DP-1 $opt1
/run/current-system/sw/bin/swww img -t random -o DP-2 $opt2
