#!/bin/bash

source ./functions.sh

echo "[alacritty] Create folder ~/.config/alacritty"
mkdir -p ~/.config/alacritty

echo "[alacritty] Link alacritty config to ~/.config/alacritty"
createSymlink ~/repos/dotfiles/alacritty/alacritty.yml ~/.config/alacritty/alacritty.yml

echo "[alacritty] Add repository ppa:aslatter/ppa"
sudo add-apt-repository ppa:aslatter/ppa -y &> /dev/null

echo "[alacritty] install"
sudo apt-get update -y &> /dev/null && sudo apt-get install alacritty -y &> /dev/null
