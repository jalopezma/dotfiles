#!/bin/bash

# debug
# set -x

# The script has the following options
# add: sets two screens
# off: returns to one screen
# change: (on init or udev rule change): will figure out which one to call (add or off)
option=${1:-change}

# Get the COMPUTER env var or "DESKTOP" if not set
computer=$(cat /tmp/computer)
computer=${computer:-DESKTOP}

logFile=/tmp/scripts.log

# Set env vars needed for xrandr
export XAUTHORITY=${XAUTHORITY:-/run/user/$(id -u)/gdm/Xauthority}
export DISPLAY=${DISPLAY:-:0}

function add() {
  local _primary=$1
  local _secondary=$2
  local _focused=$3
  local _visible1=$4
  local _visible2=$5

  if [ -z "$_secondary" ]; then
    echo "[monitors.sh] - add: No secondary monitor found" >> $logFile
    exit 1
  fi

  # On desktop the primary monitor it's on the right
  if [ $computer = "DESKTOP" ]; then
    local _tmp=$_primary
    _primary=$_secondary
    _secondary=$_tmp
    echo "[monitors.sh] - add: \"$computer\" we switch primary and secondary" >> $logFile
  fi

  xrandr --output "$_secondary" --mode 1920x1080 --right-of "$_primary"

  # Select the workspace and move it to the right monitor
  i3-msg workspace "5"
  i3-msg move workspace to "$_primary"
  i3-msg workspace "1"
  i3-msg move workspace to "$_primary"
  i3-msg workspace "2"
  i3-msg move workspace to "$_secondary"
  i3-msg workspace "6"
  i3-msg move workspace to "$_secondary"
  i3-msg workspace "4"
  i3-msg move workspace to "$_secondary"

  # Show the workspaces we had visible and focus the ws that was focused before
  i3-msg workspace "$_visible1"
  i3-msg workspace "$_visible2"
  i3-msg workspace "$_focused"
  echo "[monitors.sh] - add: Secondary monitor set" >> $logFile
}

function off() {
  local _primary=$1
  local _focused=$3

  # Disable all monitors that are disconnected and have a resolution (meaning they are not disbled)
  while IFS= read -r monitor; do
      echo "[monitors.sh] - off: Disable \"$monitor\"" >> $logFile
      $(xrandr --output "$monitor" --off)
  done < <( xrandr | grep 'disconnected [0-9]' | awk '{print $1}' )

  # I need to move workspaces from the other screen back
  i3-msg workspace "2"
  i3-msg move workspace to "$_primary"
  i3-msg workspace "6"
  i3-msg move workspace to "$_primary"
  i3-msg workspace "4"
  i3-msg move workspace to "$_primary"
  i3-msg workspace "3"
  i3-msg move workspace to "$_primary"

  # Focus the ws that was focused before
  i3-msg workspace "$_focused"
  echo "[monitors.sh] - off: Secondary monitor removed" >> $logFile
}

function change() {
  local _primary=$1
  local _secondary=$2
  local _focused=$3
  local _visible1=$4
  local _visible2=$5

  if [ -z "$_secondary" ]; then
    off $"_primary" $_focused
  else
    add "$_primary" "$_secondary" $_focused "$_visible1" "$_visible2"
  fi
}

function main() {
  local _option=$1

  primary=$(xrandr | grep primary | awk '{ print $1 }')
  # We only get the first connected monitor
  secondary=$( xrandr | grep -v primary | grep  ' connected' | awk '{ print $1 }' | head -n 1)

  echo "[monitors.sh] - primary \"$primary\" secondary \"$secondary\"" >> $logFile

  # Set primary to 1920x1080
  xrandr --output "$primary" --mode 1920x1080
  # Save which workspace is focused before setting the monitors
  focused=$(i3-msg -t get_workspaces | jq '.[] | select(.focused==true).name')
  visible1=$(i3-msg -t get_workspaces | jq '.[] | select(.visible==true).name')
  visible2=$(i3-msg -t get_workspaces | jq '.[] | select(.visible==true).name')

  if [ $_option = "add" ]; then
    add "$primary" "$secondary" $focused "$visible1" "$visible2"
  elif [ $_option = "off" ]; then
    off "$primary" $focused
  elif [ $_option = "change" ]; then
    change "$primary" "$secondary" $focused "$visible1" "$visible2"
  else
    echo "[monitors.sh] - Unknown option \"$_option\"" >> $logFile
  fi

  # Re-launch the status bars
  ~/.config/polybar/launch.sh
}

echo "[monitors.sh] --------------------------- $(date)" >> $logFile
echo "[monitors.sh] - option \"$option\" computer \"$computer\" user \"$(whoami)\"" >> $logFile
main $option
