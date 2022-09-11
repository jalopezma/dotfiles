#!/bin/bash
source ./bash/library.sh

print "[monitors] install jq"
run "$(sudo apt-get install jq -y)"

print "[monitors] Link udev rules"
createSymlink ~/repos/dotfiles/monitors/99-monitors-hotplug.rules /etc/udev/rules.d/99-monitors-hotplug.rules true
run "$(sudo chmod 0644 /etc/udev/rules.d/99-monitors-hotplug.rules)"
# run "$(touch /tmp/scripts.log && chmod 644 /tmp/scripts.log)"
print "[monitors] Reload udev rules"
run "$(sudo udevadm control --reload-rules)"

print "[monitors] Link monitor service"
run "$(sudo cp ~/repos/dotfiles/monitors/monitors.service /etc/systemd/system/monitors.service)"
run "$(sudo sed -i "s/<user>/"$(whoami)"/g" /etc/systemd/system/monitors.service)"
print "[monitors] Reload service daemon"
run "$(systemctl daemon-reload)"
