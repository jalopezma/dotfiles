#!/bin/bash
# Exit inmediatly if exits with a non-zero status.
set -o errexit
# The return value of a pipeline is the value of the last (right-most) command to exit with a non-zero status, or zero if all commands in the pipeline exit successfully.
set -o pipefail
# Treat unset variables and parameters other than the special parameters "@" and "*" as an error when performing parameter expansion. If expansion is attempted on an unset variable or parameter, the shell prints an error message, and, if not interactive, exits with a non-zero status.
set -o nounset

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
