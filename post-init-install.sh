#!/bin/bash

# Exit inmediatly if exits with a non-zero status.
set -o errexit
# The return value of a pipeline is the value of the last (right-most) command to exit with a non-zero status, or zero if all commands in the pipeline exit successfully.
set -o pipefail
# Treat unset variables and parameters other than the special parameters "@" and "*" as an error when performing parameter expansion. If expansion is attempted on an unset variable or parameter, the shell prints an error message, and, if not interactive, exits with a non-zero status.
set -o nounset

function install_chrome() {
  GOOGLE_CHROME_VERSION=$(google-chrome --version)
  if [[ $? -eq 0 ]]; then
    echo "[install] Google chrome already installed ${GOOGLE_CHROME_VERSION}"
  else
    echo "[install] Download Google chrome"
    wget -q -P /tmp/ https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
    echo "[install] Install Google chrome"
    sudo dpkg -i /tmp/google-chrome-stable_current_amd64.deb
  fi
}

function install_fonts() {
  echo "[fonts] Copy Ubuntu font"
  mkdir -p ~/.fonts
  cp -v fonts/* ~/.fonts/
}

function diff_so_fancy() {
  echo "[diff_so_fancy] Download script"
  curl -o diff-so-fancy --location \
    $(curl -s https://api.github.com/repos/so-fancy/diff-so-fancy/releases/latest |
      grep -Po 'https://github.com/so-fancy/diff-so-fancy/releases/download/.*/diff-so-fancy' |
      uniq)
  chmod +x ./diff-so-fancy
  mv diff_so_fancy ~/.local/bin/
}

function wallpapers() {
  echo "[wallpapers] Link wallpapers"
  createSymlink ~/repos/dotfiles/wallpapers ~/wallpapers
}

function set_scripts() {
  echo "[scripts] Link scripts"
  createSymlink ~/repos/dotfiles/scripts ~/scripts
}

function main() {
  # exa https://github.com/ogham/exa modern replacement for ls
  echo "[install] Install firefox flameshot snapd"
  sudo apt-get install -y firefox flameshot snapd exa

  install_chrome
  install_fonts
  wallpapers
  set_scripts
  diff_so_fancy

  bash ./git/install.sh
  bash ./zsh/install.sh
  bash ./nvm/install.sh
  bash ./nvim/install.sh
  bash ./tmux/install.sh

  bash ./rofi/install.sh
  bash ./monitors/install.sh
  bash ./i3/install.sh
  bash ./polybar/install.sh
  bash ./alacritty/install.sh
  bash ./beekeper-studio/install.sh
}

echo "[install] Post init install. Sourcing functions"
source ./functions.sh
main

# To add:
# - exa (ls tool)
