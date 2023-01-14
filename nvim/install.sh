#!/bin/bash

# Exit inmediatly if exits with a non-zero status.
set -o errexit
# The return value of a pipeline is the value of the last (right-most) command to exit with a non-zero status, or zero if all commands in the pipeline exit successfully.
set -o pipefail
# Treat unset variables and parameters other than the special parameters "@" and "*" as an error when performing parameter expansion. If expansion is attempted on an unset variable or parameter, the shell prints an error message, and, if not interactive, exits with a non-zero status.
set -o nounset

source ./functions.sh

echo "[nvim] install python3-neovim and libfuse2 (for appimages)"
sudo apt-get install python3-neovim libfuse2 -y
echo "[nvim] download nvim appimage"
curl -sLO https://github.com/neovim/neovim/releases/latest/download/nvim.appimage
chmod u+x nvim.appimage

echo "[nvim] install vimplug"
sh -c "curl -sfLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim"

dir=/usr/local/bin/nvim
echo "[nvim] nvim moved to \"$dir\""
sudo mv nvim.appimage $dir
ls -la /usr/local/bin/nvim

echo "[nvim] Link nvim folder on .config"
createSymlink ~/repos/dotfiles/nvim ~/.config/nvim

echo "[nvim] Create ~/.config/nvim/{backup_files,swap_files,undo_files}"
mkdir -p ~/.config/nvim/\{backup_files\,swap_files\,undo_files\}/

# Dependencies for nvim-telescope/telescope.nvim
echo "[nvim] Install riggrep, fd-find"
sudo apt-get install ripgrep fd-find

echo "[nvim] Install VimPlug and plugins"
nvim -es -u ~/.config/nvim/init.vim -i NONE +PlugInstall +PlugUpdate +PlugUpgrade +"TSInstall all" +CocUpdate +qall

echo "[nvim] Link nvim.desktop file"
createSymlink ~/repos/dotfiles/nvim/nvim.desktop /usr/share/applications/nvim.desktop true
