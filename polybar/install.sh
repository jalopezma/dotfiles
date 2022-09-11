#!/bin/bash
source ./bash/library.sh

print "[polybar] install.sh"
createSymlink ~/repos/dotfiles/polybar/ ~/.config/polybar

print "[polybar] Install"
run "$(sudo apt-get install polybar -y)"
