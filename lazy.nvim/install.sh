#!/bin/bash

source ./functions.sh

echo "[nvim] install python3-neovim and libfuse2 (for appimages)"
sudo apt-get install python3-neovim libfuse2 -y &> /dev/null
echo "[nvim] download nvim appimage"
curl -sLO https://github.com/neovim/neovim/releases/latest/download/nvim.appimage &> /dev/null
chmod u+x nvim.appimage

echo "[nvim] Link nvim.desktop file"
createSymlink ~/repos/dotfiles/nvim/nvim.desktop /usr/share/applications/nvim.desktop true

dir=/usr/local/bin/nvim
echo "[nvim] nvim moved to \"$dir\""
sudo mv nvim.appimage $dir

echo "[nvim] Link nvim folder on .config"
createSymlink ~/repos/dotfiles/lazy.nvim ~/.config/nvim

echo "[nvim] Create ~/.config/nvim/{backup_files,swap_files,undo_files}"
# sync: Run install, clean and update
nvim --headless "+Lazy! sync" +qa
