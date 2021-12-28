#!/bin/bash

# The script has two options
# add: sets two screens
# off: returns to one screen
option=${1:-add}

# Get the COMPUTER env var or "DESKTOP" if not set
computer=${COMPUTER:-DESKTOP}
primary=$(xrandr | grep primary | awk '{ print $1 }')
# We only get the first connected monitor
secondary=$( xrandr | grep -v primary | grep  ' connected' | awk '{ print $1 }' | head -n 1)

# Set primary to 1920x1080
xrandr --output "$primary" --mode 1920x1080

if [ $option = "add" ]; then
  if [ -z "$secondary" ]; then
    echo "No secondary monitor found"
    exit 1
  fi

  # Save which ws is focused before setting the monitors
  focused=$(i3-msg -t get_workspaces | jq '.[] | select(.focused==true).name')

  xrandr --output "$secondary" --mode 1920x1080 --right-of "$primary"

  # Select the workspace and move it to the right monitor
  i3-msg workspace "1"
  i3-msg move workspace to "$primary"
  i3-msg workspace "5"
  i3-msg move workspace to "$primary"
  i3-msg workspace "4"
  i3-msg move workspace to "$secondary"
  i3-msg workspace "6"
  i3-msg move workspace to "$secondary"

  # Focus the ws that was focused before
  i3-msg workspace "$focused"
elif [ $option = "off" ]; then
  xrandr --output DP-1 --off
else
  echo "Unknown option \"$option\""
fi

# Reload the config to re-set the bars properly
~/repos/dotfiles/i3/generate-config.sh
