#!/bin/bash

source ./functions.sh

echo "[nvim] install python3-neovim and libfuse2 (for appimages)"
sudo apt-get install python3-neovim libfuse2 -y &> /dev/null
echo "[nvim] download nvim appimage"
curl -sLO https://github.com/neovim/neovim/releases/latest/download/nvim.appimage &> /dev/null
chmod u+x nvim.appimage

echo "[nvim] Link nvim.desktop file"
createSymlink ~/repos/dotfiles/nvim/nvim.desktop /usr/share/applications/nvim.desktop

binDirectory=/usr/local/bin/nvim
echo "[nvim] nvim moved to \"$binDirectory\""
sudo mv nvim.appimage $binDirectory

echo "[nvim] Link nvim folder on .config"
createSymlink ~/repos/dotfiles/lazy.nvim ~/.config/nvim

echo "[nvim] Create ~/.config/nvim/{backup_files,swap_files,undo_files}"
mkdir -p ~/.config/nvim/{backup_files,swap_files,undo_files}/

# Dependencies for [telescope](https://github.com/nvim-telescope/telescope.nvim#suggested-dependencies)
echo "[nvim] Install plugins dependencies"
sudo apt-get install ripgrep fd-find -y &> /dev/null

echo "[nvim] Link fdfind to be executed as fd"
ln -s $(which fdfind) ~/.local/bin/fd

echo "[nvim] Install Lazy nvim and plugins"
# The bang in the command will make it wait until it's finished
nvim --headless "+Lazy! sync" +qa
