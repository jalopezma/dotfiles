#!/bin/bash
CONFIG_FILE=$(ls -CN ~/*yieldify*.ovpn 2>/dev/null)
USERNAME=$(whoami)

if [ -z $CONFIG_FILE ]; then
  echo "[yvpn] ovpn file not found in $HOME"
  exit 1
fi

sessions=$(openvpn3 sessions-list)
echo "$sessions"
if [ "$sessions" = "No sessions available" ]; then
  echo "> openvpn3 session-start --config $CONFIG_FILE $USERNAME &>/dev/null &"
  $(openvpn3 session-start --config "$CONFIG_FILE" "$USERNAME" &>/dev/null &)
  echo "[yvpn] Session started"
else
  while IFS= read -r path; do
      echo "> openvpn3 session-manage --disconnect --path $path"
      $(openvpn3 session-manage --disconnect --path "$path" &>/dev/null &)
  done < <( openvpn3 sessions-list | grep 'Path:' | awk '{print $2}' )
  echo "[yvpn] Sessions terminated"
fi
