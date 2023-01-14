#!/bin/bash

# Returns the index of the audio device? enabled
function getIndexEnabled() {
  deviceEnabled=$(pactl list short sinks | grep 'RUNNING')
  index=$(echo $deviceEnabled | awk '{print $1}')
  echo $index
}

function getArgument() {
  local _arg=$1
  argument=''

  case $_arg in
    'volume')
      argument='set-sink-volume'
      ;;
    'mute')
      argument='set-sink-mute'
      ;;
  esac
  echo $argument
}

function getOption() {
  local _options=$1
  if [ $(expr length "$_options") -gt 0 ]; then
    echo $_options
  else
    echo 'toggle'
  fi
}

# Example of use:
# pactl set-sink-volume 0 +5% #increase sound volume
# pactl set-sink-volume 0 -5% #decrease sound volume
# pactl set-sink-mute 0 toggle # mute sound
function constructCommandArgs() {
  local _arg=$1
  local _opt=$2
  local _index=$3

  arguments="$_arg $_index $_opt"

  echo $arguments
}

main() {
  local _arg=$1
  local _opt=$2

  index=$(getIndexEnabled)
  arg=$(getArgument $_arg)
  opt=$(getOption $_opt)
  commandArgs=$(constructCommandArgs $arg $opt $index)

  if [ $(expr length "$commandArgs") -gt 0 ]; then
    res=$(pactl $commandArgs)
    exit $res
  else
    exit 1
  fi
}

main $1 $2
