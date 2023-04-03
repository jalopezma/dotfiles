#!/usr/bin/env bash

# Exit inmediatly if exits with a non-zero status.
set -o errexit
# Print commands and their arguments as they are executed.
set -o xtrace
# The return value of a pipeline is the value of the last (right-most) command to exit with a non-zero status, or zero if all commands in the pipeline exit successfully.
set -o pipefail
# Treat unset variables and parameters other than the special parameters "@" and "*" as an error when performing parameter expansion. If expansion is attempted on an unset variable or parameter, the shell prints an error message, and, if not interactive, exits with a non-zero status.
set -o nounset


# Get the COMPUTER env var or "DESKTOP" if not set
COMPUTER=$(cat /tmp/computer)
COMPUTER=${COMPUTER:-DESKTOP}

LOG_FILE=/tmp/scripts.log

# Set env vars needed for xrandr
export XAUTHORITY=${XAUTHORITY:-/run/user/$(id -u)/gdm/Xauthority}
export DISPLAY=${DISPLAY:-:0}

function moveWorkspaceToScreen() {
  local _workspace=$1
  local _monitor=$2
  local _workspaces=$3

  workspaceActualOutput=$(echo $_workspaces | jq ".[\"$_workspace\"].output" | tr -d '"')
  if [ $workspaceActualOutput = "null" ]; then
    echo "[monitors.sh] - Workspace $_workspace not in use" >> $LOG_FILE
  elif [ $workspaceActualOutput = $_monitor ]; then
    echo "[monitors.sh] - workspace $_workspace already in $_monitor" >> $LOG_FILE
  else
    i3-msg workspace "$_workspace" > /dev/null
    output=$(i3-msg move workspace to output $_monitor) >> $LOG_FILE
    echo "[monitors.sh] - Workspace $_workspace to monitor $_monitor: $output" >> $LOG_FILE
  fi
}

function setWorkspacesForTwoScreens() {
  local _primary=$1
  local _secondary=$2
  local _focused=$3
  local _visible1=$4
  local _visible2=$5
  local _workspaces=$6

  # Select the workspace and move it to the right monitor
  moveWorkspaceToScreen "1" "$_primary" "$_workspaces"
  moveWorkspaceToScreen "5" "$_primary" "$_workspaces"

  moveWorkspaceToScreen "2" "$_secondary" "$_workspaces"
  moveWorkspaceToScreen "3" "$_secondary" "$_workspaces"
  moveWorkspaceToScreen "4" "$_secondary" "$_workspaces"
  moveWorkspaceToScreen "6" "$_secondary" "$_workspaces"
  moveWorkspaceToScreen "7" "$_secondary" "$_workspaces"
  moveWorkspaceToScreen "8" "$_secondary" "$_workspaces"

  # Show the workspaces we had visible and focus the ws that was focused before
  i3-msg workspace "$_visible1" > /dev/null
  i3-msg workspace "$_visible2" > /dev/null
  i3-msg workspace "$_focused" > /dev/null
}

function add() {
  local _primary=$1
  local _secondary=$2
  local _focused=$3
  local _visible1=$4
  local _visible2=$5
  local _workspaces=$6
  local _computre=$7

  if [ -z "$_secondary" ]; then
    echo "[monitors.sh] - add: No secondary monitor found" >> $LOG_FILE
    exit 1
  fi

  # On desktop the primary monitor it's on the right
  if [ $computer = "DESKTOP" ]; then
    local _tmp=$_primary
    _primary=$_secondary
    _secondary=$_tmp
    echo "[monitors.sh] - add: \"$computer\" we switch primary (now $_primary) and secondary (now $_secondary)" >> $LOG_FILE
  fi

  echo "[monitors.sh] xrandr --output \"$_secondary\" --mode 1920x1080 --right-of \"$_primary\"" >> $LOG_FILE
  xrandr --output "$_secondary" --mode 1920x1080 --right-of "$_primary"
  setWorkspacesForTwoScreens $_primary $_secondary $_focused $_visible1 $_visible2 "$_workspaces" "$_computer"

  echo "[monitors.sh] - add: Secondary monitor set" >> $LOG_FILE
}

function setWorkspacesForOneScreen() {
  local _primary=$1
  local _focused=$2
  local _workspaces=$3

  # I need to move workspaces from the other screen back
  for i in {1..8}; do
    moveWorkspaceToScreen "$i" "$_primary" "$_workspaces"
  done

  # Focus the ws that was focused before
  i3-msg workspace "$_focused" > /dev/null
}

# You will need to capture the output of this function and use head and tail to retrieve values
function setMonitorsVariables() {
  local _numMonitors=$1
  if [ "$_numMonitors" -eq "3" ]; then
    # If we have three monitors it means that we are in the laptop and we don't enable
    # the laptop screen eDP-1 (we might want to duplicate it?)
    availableMonitors=$(xrandr | grep " connected" | grep -v "eDP" | awk '{ print $1 }')
    primary=$(echo "$availableMonitors" | head -n 1)
    secondary=$(echo "$availableMonitors" | tail -n 1)
  else
    # If we have two monitors, we keep the primary one
    primary=$(xrandr | grep primary | awk '{ print $1 }')
    secondary=$(xrandr | grep -v primary | grep ' connected' | awk '{ print $1 }' | head -n 1)
  fi

  echo $primary
  echo $secondary
}

function set_laptop {
  local _numMonitors=$1
  local _primary=$2
  local _secondary=$3

  if [[ $_numMonitors -eq 3 ]]; then
    # Switch off latop screen if we have 3 screens connected
    echo "[monitors.sh] xrandr --output eDP-1 --off --output \"$_primary\" --mode 1920x1080 --output \"$_secondary\" --mode 1920x1080 --right-of \"$_primary\"" >> $LOG_FILE
    xrandr --output eDP-1 --off --output "$_primary" --mode 1920x1080 --output "$_secondary" --mode 1920x1080 --right-of "$_primary"

    echo "[monitors.sh][laptop] eDP-1 disabled as we have ${_numMonitors} monitors connected" >> $LOG_FILE
  elif [[ $_numMonitors -eq 2 ]]; then
    echo "[monitors.sh] xrandr --output \"$_primary\" --mode 1920x1080 --output \"$_secondary\" --mode 1920x1080 --right-of \"$_primary\""
    xrandr --output "$_primary" --mode 1920x1080 --output "$_secondary" --mode 1920x1080 --right-of "$_primary"
    echo "[monitors.sh][laptop] ${_numMonitors} monitors connected. $_primary right of $_primary. Both 1920" >> $LOG_FILE
  else
    echo "[monitors.sh][laptop] ${_primary} to 1920" >> $LOG_FILE
    echo "[monitors.sh] xrandr --output \"$_primary\" --mode 1920x1080"
    xrandr --output "$_primary" --mode 1920x1080
  fi
}

function set_desktop {
  local _numMonitors=$1
  # we have them switched
  local _secondary=$2
  local _primary=$3

  if [[ $_numMonitors -eq 2 ]]; then
    echo "[monitors.sh][${COMPUTER}] primary and secondary set to 1920x1080" >> $LOG_FILE
    echo "[monitors.sh] xrandr --output \"$_primary\" --mode 1920x1080 --output \"$_secondary\" --mode 1920x1080 --right-of \"$_primary\""
    xrandr --output "$_primary" --mode 1920x1080 --output "$_secondary" --mode 1920x1080 --right-of "$_primary"
  else
    echo "[monitors.sh][${COMPUTER}] primary set to 1920x1080" >> $LOG_FILE
    echo "[monitors.sh] xrandr --output \"$_primary\" --mode 1920x1080"
    xrandr --output "$_primary" --mode 1920x1080
  fi
}

function set_workspaces() {
  local _workspaces=$1
  local _numMonitors=$2
  local _primary=$3
  local _secondary=$4

  # Save which workspace is focused before setting the monitors
  ws_focused=$(echo "$_workspaces" | jq '.[] | select(.focused==true).name')
  ws_visible_in_primary=$(echo $_workspaces | jq '.[] | select(.visible==true).name' | head -n 1)
  ws_visible_in_secondary=$(echo $_workspaces | jq '.[] | select(.visible==true).name' | tail -n 1)

  if [[ $_numMonitors -ge 2 ]]; then
    setWorkspacesForTwoScreens $_primary $_secondary $ws_focused $ws_visible_in_primary $ws_visible_in_secondary "$_workspaces"
  else
    setWorkspacesForOneScreen $primary $focused "$_workspaces"
  fi
}

function main() {
  local _computer=$1

  numMonitors=$(xrandr | grep " connected" | wc -l)
  echo "[monitors.sh] number_of_monitors \"$numMonitors\"" >> $LOG_FILE

  monitors=$(setMonitorsVariables $numMonitors)
  primary=$(echo "$monitors" | head -1)
  secondary=$(echo "$monitors" | tail -1)
  echo "[monitors.sh] primary \"$primary\" secondary \"$secondary\"" >> $LOG_FILE

  # Get worskpaces, remove not wanted properties and move it to an object
  # {"<workspace_name>": { "name": "<workspace_name>", "output": "<output>", ... }}
  workspaces=$(i3-msg -t get_workspaces | jq '(map({"name": .name, "output": .output, "focused": .focused, "visible": .visible}) | INDEX(.name))')

  if [[ $_computer == "LAPTOP" ]]; then
    set_laptop $numMonitors $primary $secondary
  else
    set_desktop $numMonitors $primary $secondary
  fi

  set_workspaces "$workspaces" $numMonitors $primary $secondary

  # Re-launch the status bars
  ~/.config/polybar/launch.sh
}

echo "[monitors.sh] --------------------------- $(date)" >> $LOG_FILE
echo "[monitors.sh] computer \"$COMPUTER\" user \"$(whoami)\"" >> $LOG_FILE
main $COMPUTER
