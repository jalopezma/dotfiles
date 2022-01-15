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

logFile=$1
verbose=$2

print "[nvm] Download and install nvm"
run "$(sh -c "$(wget -q -O- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.1/install.sh)")"

# Just source the new lines nvm has added to the .bashrc file
print "[nvm] partially source .bashrc"
eval "$(cat ~/.bashrc | tail -n 3)"
print "[nvm] nvm install v16.13.1"
run "$(nvm install v16.13.1)"
