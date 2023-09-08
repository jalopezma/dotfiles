#!/bin/bash

function install_chrome() {
  google-chrome --version &> /dev/null
  if [[ $? -eq 0 ]]; then
    echo "[install] Google chrome already installed"
  else
    echo "[install] Download Google chrome"
    wget -q -P /tmp/ https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
    echo "[install] Install Google chrome"
    sudo dpkg -i /tmp/google-chrome-stable_current_amd64.deb
  fi
}

# https://github.com/eza-community/eza/releases modern replacement for ls
function install_eza() {
  eza --version &>/dev/null
  if [[ $? -eq 0 ]]; then
    echo "[install] Exa already installed"
  else
    echo "[eza] Not instlled. Downloading script"
    mkdir -p ~/.local/bin
    curl -s -o /tmp/eza --location \
      $(curl -s https://api.github.com/repos/eza-community/eza/releases/latest |
        grep -Po 'https://github.com/eza-community/eza/releases/download/.*/x86_64-unknown-linux-gnu-eza' |
        uniq)
    chmod +x /tmp/eza
    echo "[eza] Move to ~/.local/bin/eza"
    mv /tmp/eza ~/.local/bin/eza
  fi
}

function wallpapers() {
  echo "[wallpapers] Link wallpapers"
  createSymlink ~/repos/dotfiles/wallpapers ~/wallpapers
}

function set_scripts() {
  echo "[scripts] Link scripts"
  createSymlink ~/repos/dotfiles/scripts ~/scripts
}

function bluetooth() {
  echo "[install] Install blueman"
  sudo apt-get install -y blueman &> /dev/null
}

function backlight() {
  echo "[install] Install backlight tools"
  sudo apt-get install -y xbacklight &> /dev/null
}

function golang_version_manager() {
  # https://github.com/moovweb/gvm
  gvm --version &> /dev/null
  if [[ $? -eq 0 ]]; then
    echo "[install] gvm already installed"
  else
    echo "[install] Installing gvm"
    if [[ -d ~/.gvm ]]; then
      echo "[install] Remove ~/.gvm"
      rm -rf ~/.gvm
    fi
    sudo apt-get install -y bison &> /dev/null
    bash < <(curl -s -S -L https://raw.githubusercontent.com/moovweb/gvm/master/binscripts/gvm-installer) &> /dev/null
    echo "[install] Source gvm"
    source "$HOME/.gvm/scripts/gvm" &> /dev/null
    echo "[install] We need to install go1.4 first"
    gvm install go1.4 -B &> /dev/null
    gvm use go1.4 &> /dev/null
    export GOROOT_BOOTSTRAP=$GOROOT
    echo "[install] Install go1.17 as is needed for go1.21"
    gvm install go1.17.13 &> /dev/null
    gvm use go1.17.13 &> /dev/null
    export GOROOT_BOOTSTRAP=$GOROOT
    gvm install go1.21 &> /dev/null
    echo "[install] Set go1.21 as default"
    gvm use go1.21 --default &> /dev/null
  fi
  echo "[install] Exit gvm"
}

function python_version_manager() {
  # https://github.com/pyenv/pyenv
  pyenv version &> /dev/null
  if [[ $? -eq 0 ]]; then
    echo "[install] pyenv already installed"
  else
    echo "[install] Installing pyenv dependencies"
    sudo apt-get install -y build-essential zlib1g-dev libffi-dev libssl-dev libbz2-dev libreadline-dev libsqlite3-dev liblzma-dev python3-tk python-tk tk-dev &> /dev/null
    echo "[install] Installing pyenv"
    curl https://pyenv.run | bash &> /dev/null
    echo "[install] source pyenv"
    export PYENV_ROOT="$HOME/.pyenv"
    command -v pyenv > /dev/null || export PATH="$PYENV_ROOT/bin:$PATH"
    eval "$(pyenv init -)"
    echo "[install] Python 3.11.1"
    pyenv install 3.11.1
    pyenv global 3.11.1
  fi
}

function set_ssh() {
  mkdir -p ~/.ssh
  chmod 0700 ~/.ssh
  echo "[ssh] Linking ~/.ssh/config"
  createSymlink ~/repos/dotfiles/ssh/config ~/.ssh/config
}

function main() {
  echo "[install] Install firefox flameshot snapd htop"
  sudo apt-get install -y firefox flameshot snapd htop &> /dev/null

  set_ssh

  install_chrome
  wallpapers
  set_scripts

  install_eza
  bluetooth
  backlight
  golang_version_manager
  python_version_manager

  bash ./fonts/install.sh
  bash ./git/install.sh
  bash ./zsh/install.sh
  bash ./volta/install.sh
  bash ./nvim/install.sh
  bash ./tmux/install.sh

  bash ./rofi/install.sh
  bash ./monitors/install.sh
  bash ./i3/install.sh
  bash ./polybar/install.sh
  bash ./alacritty/install.sh
  bash ./beekeper-studio/install.sh
  bash ./sound-switcher/install.sh
}

echo "[install] Post init install. Sourcing functions"
source ./functions.sh
main
