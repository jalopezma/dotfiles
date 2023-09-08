#!/bin/bash

echo "[monitors] install jq"
sudo apt-get install jq -y &> /dev/null

if [[ -f /etc/udev/rules.d/99-monitors-hotplug.rules ]]; then
  echo "[monitors] Monitor udev rules already there. Removing"
  sudo rm /etc/udev/rules.d/99-monitors-hotplug.rules
fi
echo "[monitors] Link udev rules"
sudo ln -s ~/repos/dotfiles/monitors/99-monitors-hotplug.rules /etc/udev/rules.d/99-monitors-hotplug.rules
sudo chmod 0644 /etc/udev/rules.d/99-monitors-hotplug.rules

echo "[monitors] Reload udev rules"
sudo udevadm control --reload-rules &> /dev/null

echo "[monitors] Link monitor service"
sudo cp ~/repos/dotfiles/monitors/monitors.service /etc/systemd/system/monitors.service
sudo sed -i "s/<user>/"$(whoami)"/g" /etc/systemd/system/monitors.service
echo "[monitors] Reload service daemon"
systemctl daemon-reload
