#!/bin/bash
source ./bash/library.sh

print "[alacritty] Link alacritty folder to ~/.config"
createSymlink ~/repos/dotfiles/alacritty ~/.config/alacritty

print "[alacritty] Add repository"
run "$(sudo sudo add-apt-repository ppa:mmstick76/alacritty -y)" $verbose

print "[alacritty] install"
run "$(sudo apt-get update -y && sudo apt-get install alacritty -y)" $verbose
