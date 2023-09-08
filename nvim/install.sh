#!/bin/bash

source ./functions.sh

echo "[nvim] install python3-neovim and libfuse2 (for appimages)"
sudo apt-get install python3-neovim libfuse2 -y &> /dev/null
echo "[nvim] download nvim appimage"
curl -sLO https://github.com/neovim/neovim/releases/latest/download/nvim.appimage &> /dev/null
chmod u+x nvim.appimage

echo "[nvim] Link nvim.desktop file"
createSymlink ~/repos/dotfiles/nvim/nvim.desktop /usr/share/applications/nvim.desktop true

echo "[nvim] install vimplug"
sh -c "curl -sfLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim" &> /dev/null

dir=/usr/local/bin/nvim
echo "[nvim] nvim moved to \"$dir\""
sudo mv nvim.appimage $dir

echo "[nvim] Link nvim folder on .config"
createSymlink ~/repos/dotfiles/nvim ~/.config/nvim

echo "[nvim] Create ~/.config/nvim/{backup_files,swap_files,undo_files}"
mkdir -p ~/.config/nvim/\{backup_files\,swap_files\,undo_files\}/

# Dependencies for nvim-telescope/telescope.nvim
echo "[nvim] Install riggrep, fd-find"
sudo apt-get install ripgrep fd-find &> /dev/null

echo "[nvim] Install VimPlug and plugins"
# nvim -es -u ~/.config/nvim/init.vim -i NONE +PlugInstall +PlugUpdate +PlugUpgrade +"TSInstall all" +CocUpdate +qall
