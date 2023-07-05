/bin/sh
killall -q polybar

if type "xrandr"; then
  for m in $(xrandr --query | grep " connected" | cut -d" " -f1); do
    MONITOR=$m polybar --reload panel -c ~/.config/polybar/config.ini &
  done
else
  polybar --reload panel -c ~/.config/polybar/config.ini &
fi
