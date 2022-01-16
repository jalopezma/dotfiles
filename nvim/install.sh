#!/bin/bash

# Helps to print the output of the command if the verbose flag is set
run() {
  local output=$1
  if $verbose && [ ! -z $output ]; then
    echo "$output"
  fi
  echo "$output" >> $logFile
}

# Prints to stdout and log file
print() {
  echo "$1"
  echo "$1" >> $logFile
}

createSymlink() {
  local from=$1
  local to=$2
  if [ -f $to ] || [ -d $to ]; then
    echo "[nvim] File $to already exists"
  else
    run "$(ln -s $from $to)" $verbose
  fi
}

logFile=$1
verbose=$2

print "[nvim] install python3-neovim"
run "$(sudo apt-get install python3-neovim -y)"
print "[nvim] download nvim appimage"
run "$(curl -sLO https://github.com/neovim/neovim/releases/latest/download/nvim.appimage)"
run "$(chmod u+x nvim.appimage)"

print "[nvim] install vimplug"
run "$(sh -c "curl -sfLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim")"

dir=/usr/local/bin/nvim
print "[nvim] nvim moved to \"$dir\""
run "$(sudo mv nvim.appimage $dir)"
run "$(ls -la /usr/local/bin/nvim)"

print "[nvim] Link nvim folder on .config"
createSymlink ~/repos/dotfiles/nvim ~/.config/nvim

print "[nvim] Create ~/.config/nvim/{backup_files,swap_files,undo_files}"
run "$(mkdir -p ~/.config/nvim/\{backup_files\,swap_files\,undo_files\}/)"

# Dependencies for nvim-telescope/telescope.nvim
print "[nvim] Install riggrep, fd-find"
run "$(sudo apt-get install ripgrep fd-find)"

print "[nvim] Install VimPlug and plugins"
run "$(nvim -es -u ~/.config/nvim/init.vim -i NONE +PlugInstall +PlugUpdate +PlugUpgrade +"TSInstall all" +CocUpdate +qall)"
