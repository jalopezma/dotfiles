#!/bin/bash

if [[ ! -d "/tmp/setup" ]]; then
  echo "mkdir /tmp/setup"
  mkdir /tmp/setup
fi

echo "cd /tmp/setup"
cd /tmp/setup
echo $(pwd)

if [[ ! -d "~/.local/bin" ]]; then
  echo "Create ~/.local/bin folder"
  mkdir -p ~/.local/bin
fi

echo "Download hush and move hush to ~/.local/bin/hush"
curl -so hush.tar.gz --location \
  $(curl -s https://api.github.com/repos/hush-shell/hush/releases \
    | grep -oP 'https://github.com/hush-shell/hush/releases/download/[^}]*static-x86_64.tar.gz' \
    | head -n 1 \
  ) \
  && tar -x hush -f hush.tar.gz && /bin/rm hush.tar.gz \
  && chmod +x ./hush && mv ./hush ~/.local/bin/hush

echo "Download hush installation script"
wget -q --show-progress https://raw.githubusercontent.com/jalopezma/dotfiles/feat/move-bash-to-hush/install-hush.hsh /tmp/setup/install-hush.hsh

echo "execute ~/.local/bin/hush /tmp/setup/install-hush.hsh"
# It's not sourced yet so we call it directly
~/.local/bin/hush /tmp/setup/install-hush.hsh
