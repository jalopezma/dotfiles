#!/bin/bash

source ./functions.sh

echo "[tmux] Install tmux"
sudo apt-get install tmux -y &> /dev/null

echo "[tmux] Link to ~/.tmux.conf"
createSymlink ~/repos/dotfiles/tmux/.tmux.conf ~/.tmux.conf
