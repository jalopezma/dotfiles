#!/bin/bash
source ./bash/library.sh

print "[beekeper] Install beekeper GPG key"
run "$(wget --quiet -O - https://deb.beekeeperstudio.io/beekeeper.key | sudo apt-key add -)"

print "[beekeper] Add repo to apt lists directory"
run "$(echo "deb https://deb.beekeeperstudio.io stable main" | sudo tee /etc/apt/sources.list.d/beekeeper-studio-app.list)"

print "[beekeper] Update apt and install"
run "$(sudo apt-get update && sudo apt-get install beekeeper-studio)"
