#!/usr/bin/env sh

## Add this to your wm startup file.

# Terminate already running bar instances
killall -q polybar

# Wait until the processes have been shut down
while pgrep -u $(id -u) -x polybar >/dev/null; do sleep 0.2; done

# Launch the same bar for each monitor
for m in $(polybar --list-monitors | cut -d":" -f1); do
  MONITOR=$m polybar -c ~/.config/polybar/config.ini main &
done
