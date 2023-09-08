#!/bin/bash

# https://volta.sh/
echo "[volta] Download and install volta"
curl -s https://get.volta.sh | bash &> /dev/null

echo "[volta] Install latests node"
# volta env var has not been reflected yet
~/.volta/bin/volta install node@latest &> /dev/null
