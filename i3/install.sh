#!/bin/bash

# Helps to print the output of the command if the verbose flag is set
run() {
  local output=$1
  local verbose=${2:-false}
  if $verbose; then
    echo "$output"
  fi
  echo "$output" >> $logFile
}

# Prints to stdout and log file
print() {
  echo "$1"
  echo "$1" >> $logFile
}

createSymlink() {
  local from=$1
  local to=$2
  if [ -f $to ] || [ -d $to ]; then
    echo "[i3] File $to already exists"
  else
    run "$(ln -s $from $to)" $verbose
  fi
}

logFile=$1
verbose=$2

print "[i3] Link i3 folder to ~/.config"
createSymlink ~/repos/dotfiles/i3 ~/.config/i3

print "[i3] Install i3 rofi feh compton pavucontrol"
run "$(sudo apt-get install i3 rofi feh compton pavucontrol -y)" $verbose

print "[i3] Generate i3 config"
run "$(sh ~/repos/dotfiles/i3/generate-config.sh false)" $verbose
