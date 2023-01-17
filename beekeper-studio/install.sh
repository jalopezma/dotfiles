#!/bin/bash

# Exit inmediatly if exits with a non-zero status.
set -o errexit
# The return value of a pipeline is the value of the last (right-most) command to exit with a non-zero status, or zero if all commands in the pipeline exit successfully.
set -o pipefail
# Treat unset variables and parameters other than the special parameters "@" and "*" as an error when performing parameter expansion. If expansion is attempted on an unset variable or parameter, the shell prints an error message, and, if not interactive, exits with a non-zero status.
set -o nounset

echo "[beekeper] Download beekeeper-studio from github"
curl -o /tmp/beekeeper-studio.deb --location \
  $(curl -sL https://api.github.com/repos/beekeeper-studio/beekeeper-studio/releases/latest |
    grep -Po 'https://github.com/beekeeper-studio/beekeeper-studio/releases/download/.*amd64.deb' |
    uniq)
chmod +x /tmp/beekeeper-studio.deb
sudo dpkg -i /tmp/beekeeper-studio.deb
