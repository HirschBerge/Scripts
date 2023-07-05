#!/usr/bin/env sh

## Add this to your wm startup file.

# Terminate already running bar instances
 kill_running_instances() {
        pkill polybar || true 
        while pgrep -u "$(id -u)" -x polybar >/dev/null; do
          sleep 0.25
        done
      }

# Wait until the processes have been shut down
kill_running_instances
sleep 1
config_path="/home/hirschy/.config/polybar/config.ini"
polybar -q -r top-primary -c $config_path &
polybar -q -r bottom-primary -c $config_path &
polybar -q -r top-secondary -c $config_path &
polybar -q -r bottom-secondary -c $config_path &
#polybar bottom -c ~/.config/polybar/config-bottom.ini &
#polybar panel -r -c ~/.config/polybar/config.ini &
#polybar top -c ~/.config/polybar/config-top.ini &

ln -sf /tmp/polybar_mqueue.$! /tmp/ipc-bottom

echo message >/tmp/ipc-bottom
