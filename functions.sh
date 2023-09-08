#!/bin/bash

## Used to check whether the script was sourced in order to set the environment variables
## in your shell (https://unix.stackexchange.com/a/424495)
if [ "${BASH_SOURCE[0]}" -ef "$0" ]; then
  echo "Hey, you should source this script, not execute it!"
  echo "Otherwise, the functions won't be set in your shell!"
  exit -127
fi

createSymlink() {
  local from=$1
  local to=$2
  if [[ -f $to ]] || [[ -d $to ]]; then
    echo "[main] File/folder \"$to\" already exists"
  else
    ln -s $from $to
  fi
}
