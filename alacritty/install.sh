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
    echo "[alacritty] File $to already exists"
  else
    run "$(ln -s $from $to)" $verbose
  fi
}

logFile=$1
verbose=$2

print "[alacritty] Create folder ~/.config/alacritty"
run "$(mkdir -p ~/.config/alacritty)"

print "[alacritty] Link alacritty config to ~/.config/alacritty"
createSymlink ~/repos/dotfiles/alacritty/alacritty.yml ~/.config/alacritty/alacritty.yml

print "[alacritty] Add repository ppa:aslatter/ppa"
run "$(sudo add-apt-repository ppa:aslatter/ppa -y)" $verbose

print "[alacritty] install"
run "$(sudo apt-get update -y && sudo apt-get install alacritty -y)" $verbose
