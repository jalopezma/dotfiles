#!/bin/bash

source ./functions.sh

function install_diff_so_fancy() {
  diff-so-fancy &>/dev/null
  if [[ $? -eq 0 ]]; then
    echo "[git] diff-so-fancy already installed"
  else
    echo "[git] Installing diff_so_fancy"
    curl -s -o diff-so-fancy --location \
      $(curl -s https://api.github.com/repos/so-fancy/diff-so-fancy/releases/latest |
        grep -Po 'https://github.com/so-fancy/diff-so-fancy/releases/download/.*/diff-so-fancy' |
        uniq)
    chmod +x ./diff-so-fancy
    mv ./diff-so-fancy ~/.local/bin/
  fi
  echo "[git] Exit diff-so-fancy"
}

function install_git_delta() {
  delta --version &>/dev/null
  if [[ $? -eq 0 ]]; then
    echo "[git] delta already installed"
  else
    echo "[git] Installing delta"
    curl -o /tmp/git-delta_amd64.deb --location \
      $(curl -s https://api.github.com/repos/dandavison/delta/releases/latest |
        grep -Po 'https://github.com/dandavison/delta/releases/download/.*git-delta_.*_amd64.deb' |
        uniq)
    chmod +x /tmp/git-delta_amd64.deb
    sudo dpkg -i /tmp/git-delta_amd64.deb
  fi
  echo "[git] Exit delta"
}

echo "[git] Link .gitconfig"
createSymlink ~/repos/dotfiles/git/.gitconfig ~/.gitconfig

echo "[git] Set user name and email"
git config --global user.name "Jose Lopez"
git config --global user.email "joseadrian.lopezmartin@gmail.com"

install_diff_so_fancy
install_git_delta
