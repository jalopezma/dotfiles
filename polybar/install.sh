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
    echo "[polybar] File $to already exists"
  else
    run "$(ln -s $from $to)" $verbose
  fi
}

logFile=$1
verbose=$2

print "[polybar] install.sh"
createSymlink ~/repos/dotfiles/polybar/ ~/.config/polybar

print "[polybar] Install"
run "$(sudo apt-get install polybar -y)"

