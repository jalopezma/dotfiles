#!/bin/bash

# Exit inmediatly if exits with a non-zero status.
set -o errexit
# The return value of a pipeline is the value of the last (right-most) command to exit with a non-zero status, or zero if all commands in the pipeline exit successfully.
set -o pipefail
# Treat unset variables and parameters other than the special parameters "@" and "*" as an error when performing parameter expansion. If expansion is attempted on an unset variable or parameter, the shell prints an error message, and, if not interactive, exits with a non-zero status.
set -o nounset

source ./functions.sh

echo "[alacritty] Create folder ~/.config/alacritty"
mkdir -p ~/.config/alacritty

echo "[alacritty] Link alacritty config to ~/.config/alacritty"
createSymlink ~/repos/dotfiles/alacritty/alacritty.yml ~/.config/alacritty/alacritty.yml

echo "[alacritty] Add repository ppa:aslatter/ppa"
sudo add-apt-repository ppa:aslatter/ppa -y

echo "[alacritty] install"
sudo apt-get update -y && sudo apt-get install alacritty -y
