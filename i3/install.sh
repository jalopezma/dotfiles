#!/bin/bash
source ./bash/library.sh

print "[i3] Link i3 folder to ~/.config"
createSymlink ~/repos/dotfiles/i3 ~/.config/i3

print "[i3] Install i3 rofi feh compton pavucontrol"
run "$(sudo apt-get install i3 rofi feh compton pavucontrol -y)" $verbose

print "[i3] Generate i3 config"
run "$(sh ~/repos/dotfiles/i3/generate-config.sh false)" $verbose
