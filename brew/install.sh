#!/bin/bash

source ./functions.sh

echo "[brew] Install brew"
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

echo "[brew] source brew to install packages"
eval "$(~/.linuxbrew/bin/brew shellenv)"

echo "[brew] Install fzf and bat"
brew install fzf bat
