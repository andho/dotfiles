#!/usr/bin/env sh

## Add this to your wm startup file.

# Terminate already running bar instances
killall -q polybar

## Wait until the processes have been shut down
while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done

export MONITOR=DisplayPort-1

## Launch
polybar -c ~/.config/polybar/config datetime &
polybar -c ~/.config/polybar/config example &
polybar -c ~/.config/polybar/config modebar &
polybar -c ~/.config/polybar/config workspace &

export MONITOR=HDMI-A-0

## Launch
polybar -c ~/.config/polybar/config datetime &
polybar -c ~/.config/polybar/config example &
polybar -c ~/.config/polybar/config modebar &
polybar -c ~/.config/polybar/config workspace &
#MONITOR=$MONITOR_NAME polybar -c ~/.config/polybar/config songs &
#MONITOR=$MONITOR_NAME polybar -c ~/.config/polybar/config player &
# MONITOR=$MONITOR_NAME polybar -c ~/.config/polybar/config left &
# MONITOR=$MONITOR_NAME polybar -c ~/.config/polybar/config center &
# MONITOR=$MONITOR_NAME polybar -c ~/.config/polybar/config right &
# MONITOR=$MONITOR_NAME polybar -c ~/.config/polybar/config power &
