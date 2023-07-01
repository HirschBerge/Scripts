#!/bin/sh
nvidia-settings --assign CurrentMetaMode="DP-2: nvidia-auto-select @O +0+0 {ForceCompositionPipeline=On}, DP-0: nvidia-auto-select @2560x1080 +0+1080 {ForceCompositionPipeline=On}"
xrandr --output DP-2 --mode 2560x1080 --rate 200 --pos 0x1080 --output DP-0 --mode 2560x1080 --rate 200 --pos 0x0
