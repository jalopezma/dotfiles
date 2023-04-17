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

# exa https://github.com/ogham/exa modern replacement for ls
function install_exa() {
  echo "[exa] Download script"
  mkdir -p ~/.local/bin
  curl -o /tmp/exa.zip --location \
    $(curl -s https://api.github.com/repos/ogham/exa/releases/latest |
      grep -Po 'https://github.com/ogham/exa/releases/download/.*/exa-linux-x86_64-v.*.zip' |
      uniq)
  unzip /tmp/exa.zip -d /tmp
  chmod +x /tmp/bin/exa
  mv /tmp/bin/exa ~/.local/bin/exa
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
  sudo apt-get install -y blueman
}

function backlight() {
  echo "[install] Install backlight tools"
  sudo apt-get install -y xbacklight
}

function golang_version_manager() {
  # https://github.com/moovweb/gvm
  echo "[install] Install dependencies and Golang version manager"
  sudo apt-get install -y bison
  bash < <(curl -s -S -L https://raw.githubusercontent.com/moovweb/gvm/master/binscripts/gvm-installer)
  echo "[install] Source gvm"
  source "$HOME/.gvm/scripts/gvm"
  echo "[install] We need to install go1.4 first"
  gvm install go1.4 -B
  gvm use go1.4
  export GOROOT_BOOTSTRAP=$GOROOT
  echo "[install] Install go1.19 an use it"
  gvm install go1.19
  gvm use go1.19 --default
}

function python_version_manager() {
  # https://github.com/pyenv/pyenv
  echo "[install] Install pyenv and dependencies"
  sudo apt-get install -y build-essential zlib1g-dev libffi-dev libssl-dev libbz2-dev libreadline-dev libsqlite3-dev liblzma-dev python3-tk python-tk tk-dev
  curl https://pyenv.run | bash
  echo "[install] source pyenv"
  export PYENV_ROOT="$HOME/.pyenv"
  command -v pyenv > /dev/null || export PATH="$PYENV_ROOT/bin:$PATH"
  eval "$(pyenv init -)"
  echo "[install] Python 3.11.1"
  pyenv install 3.11.1
  pyenv global 3.11.1
}

function set_ssh() {
  mkdir -p ~/.ssh
  chmod 0700 ~/.ssh
  createSymlink ~/repos/dotfiles/ssh/config ~/.ssh/config
}

function main() {
  echo "[install] Install firefox flameshot snapd htop"
  sudo apt-get install -y firefox flameshot snapd htop

  set_ssh

  install_chrome
  install_fonts
  wallpapers
  set_scripts

  install_exa
  bluetooth
  backlight
  golang_version_manager

  bash ./git/install.sh
  bash ./zsh/install.sh
  bash ./nvm/install.sh
  bash ./nvim/install.sh
  # bash ./tmux/install.sh

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
