#!/bin/bash

echo "[beekeper] Download beekeeper-studio from github"
curl -s -o /tmp/beekeeper-studio.deb --location \
  $(curl -sL https://api.github.com/repos/beekeeper-studio/beekeeper-studio/releases/latest |
    grep -Po 'https://github.com/beekeeper-studio/beekeeper-studio/releases/download/.*amd64.deb' |
    uniq)
chmod +x /tmp/beekeeper-studio.deb
sudo dpkg -i /tmp/beekeeper-studio.deb &> /dev/null
