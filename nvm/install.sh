#!/bin/bash

# Exit inmediatly if exits with a non-zero status.
set -o errexit
# The return value of a pipeline is the value of the last (right-most) command to exit with a non-zero status, or zero if all commands in the pipeline exit successfully.
set -o pipefail
# Treat unset variables and parameters other than the special parameters "@" and "*" as an error when performing parameter expansion. If expansion is attempted on an unset variable or parameter, the shell prints an error message, and, if not interactive, exits with a non-zero status.
set -o nounset

source ./functions.sh

echo "[nvm] Download and install nvm"
sh -c "$(wget -q -O- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.1/install.sh)"

# Just source the new lines nvm has added to the .bashrc file
echo "[nvm] partially source .bashrc"
eval "$(cat ~/.bashrc | tail -n 3)"
echo "[nvm] nvm install v16.15.0 (the one set in nvim)"
nvm install v16.15.0
