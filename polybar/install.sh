#!/bin/bash

source ./functions.sh

echo "[polybar] install.sh"
createSymlink ~/repos/dotfiles/polybar/ ~/.config/polybar

echo "[polybar] Install"
sudo apt-get install polybar -y &> /dev/null
