#!/bin/bash
source ./bash/library.sh

print "[nvm] Download and install nvm"
run "$(sh -c "$(wget -q -O- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.1/install.sh)")"

# Just source the new lines nvm has added to the .bashrc file
print "[nvm] partially source .bashrc"
eval "$(cat ~/.bashrc | tail -n 3)"
print "[nvm] nvm install v16.13.1"
run "$(nvm install v16.13.1)"
