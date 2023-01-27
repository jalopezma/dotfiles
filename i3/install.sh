#!/bin/bash

# Exit inmediatly if exits with a non-zero status.
set -o errexit
# The return value of a pipeline is the value of the last (right-most) command to exit with a non-zero status, or zero if all commands in the pipeline exit successfully.
set -o pipefail
# Treat unset variables and parameters other than the special parameters "@" and "*" as an error when performing parameter expansion. If expansion is attempted on an unset variable or parameter, the shell prints an error message, and, if not interactive, exits with a non-zero status.
set -o nounset
set -x

source ./functions.sh

echo "[i3] Link i3 folder to ~/.config"
createSymlink ~/repos/dotfiles/i3 ~/.config/i3

echo "[i3] Install i3 rofi feh compton pavucontrol"
sudo apt-get install i3 rofi feh compton pavucontrol -y

echo "[i3] Generate i3 config"
sh ~/repos/dotfiles/i3/generate-config.sh false

echo "[i3] Installing imagemagick dependencie for betterlockscreen"
sudo apt-get install -y imagemagick

echo "[i3] Installing i3lock-color needed for betterlockscreen"
sudo apt-get -y install autoconf gcc make pkg-config libpam0g-dev libcairo2-dev libfontconfig1-dev libxcb-composite0-dev libev-dev libx11-xcb-dev libxcb-xkb-dev libxcb-xinerama0-dev libxcb-randr0-dev libxcb-image0-dev libxcb-util-dev libxcb-xrm-dev libxkbcommon-dev libxkbcommon-x11-dev libjpeg-dev

REPO_FOLDER="~/repos/i3lock-color"
if [[ -d $REPO_FOLDER ]]; then
  echo "[i3] $REPO_FOLDER exists. Deleting the folder to download the latest version"
  rm -rf $REPO_FOLDER
fi

echo "[i3] Cloning $REPO_FOLDER && cd $REPO_FOLDER"
git clone https://github.com/Raymo111/i3lock-color.git $REPO_FOLDER && cd $REPO_FOLDER

echo "[i3] Build and install"
./install-i3lock-color.sh

echo "[i3] betterlockscreen"
wget https://raw.githubusercontent.com/betterlockscreen/betterlockscreen/main/install.sh -O - -q | sudo bash -s system latest true

WALLPAPER_LEFT_SCREEN="~/wallpapers/dani-pedrosa-motogp-honda-rc213v-honda-hrc-spanish-racer.jpg"
WALLPAPER_RIGHT_SCREEN="~/wallpapers/jorge-lorenzo-4k-buriram-2018-bikes-motogp.jpg"
echo "[i3] Set wallpapers for lock screen"
betterlockscreen \
  -u $WALLPAPER_LEFT_SCREEN --display 1 \
  -u $WALLPAPER_RIGHT_SCREEN --display 2
#  -u $WALLPAPER_LEFT_SCREEN --fx blur --display 1 \
#  -u WALLPAPER_RIGHT_SCREEN --fx blur --display 2
