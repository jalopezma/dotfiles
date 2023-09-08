#!/bin/bash

source ./functions.sh

echo "[i3] Link i3 folder to ~/.config"
createSymlink ~/repos/dotfiles/i3 ~/.config/i3

echo "[i3] Install i3 rofi feh compton pavucontrol"
sudo apt-get install i3 rofi feh compton pavucontrol -y &> /dev/null

echo "[i3] Generate i3 config"
sh ~/repos/dotfiles/i3/generate-config.sh &> /dev/null

echo "[i3] Installing imagemagick dependencie for betterlockscreen"
sudo apt-get install -y imagemagick &> /dev/null

echo "[i3] Installing i3lock-color needed for betterlockscreen"
sudo apt-get -y install autoconf gcc make pkg-config libpam0g-dev libcairo2-dev libfontconfig1-dev libxcb-composite0-dev libev-dev libx11-xcb-dev libxcb-xkb-dev libxcb-xinerama0-dev libxcb-randr0-dev libxcb-image0-dev libxcb-util-dev libxcb-xrm-dev libxkbcommon-dev libxkbcommon-x11-dev libjpeg-dev &> /dev/null

REPO_FOLDER="~/repos/i3lock-color"
if [[ -d $REPO_FOLDER ]]; then
  echo "[i3] $REPO_FOLDER exists. Deleting the folder to download the latest version"
  rm -rf $REPO_FOLDER
fi

echo "[i3] Cloning $REPO_FOLDER && cd $REPO_FOLDER"
git clone https://github.com/Raymo111/i3lock-color.git $REPO_FOLDER &> /dev/null && cd $REPO_FOLDER

echo "[i3] Build and install"
./install-i3lock-color.sh &> /dev/null

echo "[i3] betterlockscreen"
wget https://raw.githubusercontent.com/betterlockscreen/betterlockscreen/main/install.sh -O - -q | sudo bash -s system latest true &> /dev/null

WALLPAPER_LEFT_SCREEN="${HOME}/repos/dotfiles/wallpapers/dani-pedrosa-motogp-honda-rc213v-honda-hrc-spanish-racer.jpg"
WALLPAPER_RIGHT_SCREEN="${HOME}/repos/dotfiles/wallpapers/jorge-lorenzo-4k-buriram-2018-bikes-motogp.jpg"
echo "[i3] Set wallpapers for lock screen"
betterlockscreen \
  -u $WALLPAPER_LEFT_SCREEN --display 1 \
  -u $WALLPAPER_RIGHT_SCREEN --display 2 &> /dev/null
#  -u $WALLPAPER_LEFT_SCREEN --fx blur --display 1 \
#  -u WALLPAPER_RIGHT_SCREEN --fx blur --display 2
