#!/bin/bash

echo "[sound-switcher] Install indicator-sound-switcher"
sudo apt-add-repository -y ppa:yktooo/ppa &> /dev/null \
  && sudo apt-get update -y &> /dev/null \
  && sudo apt-get install -y indicator-sound-switcher &> /dev/null
