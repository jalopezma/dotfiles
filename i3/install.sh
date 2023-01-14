#!/bin/bash

# Exit inmediatly if exits with a non-zero status.
set -o errexit
# The return value of a pipeline is the value of the last (right-most) command to exit with a non-zero status, or zero if all commands in the pipeline exit successfully.
set -o pipefail
# Treat unset variables and parameters other than the special parameters "@" and "*" as an error when performing parameter expansion. If expansion is attempted on an unset variable or parameter, the shell prints an error message, and, if not interactive, exits with a non-zero status.
set -o nounset

source ./functions.sh

echo "[i3] Link i3 folder to ~/.config"
createSymlink ~/repos/dotfiles/i3 ~/.config/i3

echo "[i3] Install i3 rofi feh compton pavucontrol"
sudo apt-get install i3 rofi feh compton pavucontrol -y

echo "[i3] Generate i3 config"
sh ~/repos/dotfiles/i3/generate-config.sh false
