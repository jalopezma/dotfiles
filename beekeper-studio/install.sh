#!/bin/bash

# Helps to print the output of the command if the verbose flag is set
run() {
  local output=$1
  if $verbose && [ ! -z $output ]; then
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
    echo "[beekeper] File $to already exists"
  else
    run "$(ln -s $from $to)" $verbose
  fi
}

logFile=$1
verbose=$2

print "[beekeper] Install beekeeper-studio with snap"
run "$(sudo snap install beekeeper-studio)"
