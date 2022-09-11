#!/bin/bash
verbose=false
logFolder=/tmp/jalopezma-install
logFile="$logFolder/install.log"

setLogFile() {
  if [ ! -d "$logFolder" ]; then
    mkdir $logFolder
  fi

  if [ ! -f "$logFile" ]; then
    touch $logFile
  fi

  echo "$(date)" >> $logFile
}

# Helps to print the output of the command if the verbose flag is set
run() {
  local output=$1
  local verbose=${2:-false}
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
    echo "[main] File/folder \"$to\" already exists"
  else
    run "$(ln -s $from $to)" $verbose
  fi
}


parseArguments() {
  # $@ is all command line parameters passed to the script.
  # -o is for short options like -v
  # -l is for long options with double dash like --help
  # the comma separates different long options
  # -a is for long options with single dash like -version
  options=$(getopt -l "help,debug,verbose" -o "hdv" -- "$@")

  # set --:
  # If no arguments follow this option, then the positional parameters are unset. Otherwise, the positional parameters are set to the arguments, even if some of them begin with a ‘-’.
  eval set -- "$options"

  while true
  do
  case $1 in
  -h|--help)
      showHelp
      exit 0
      ;;
  -v|--verbose)
      export verbose=true
      ;;
  -d|--debug)
      set -xv  # Set xtrace and verbose mode.
      ;;
  --)
      shift
      break;;
  esac
  shift
  done
}

