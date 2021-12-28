#!/bin/bash
CONFIG_FILE='/home/joselopez/yieldify_laptop_jose_lopez@yieldify_com@_[London].ovpn'
USERNAME=$(whoami)

sessions=$(openvpn3 sessions-list)
echo "$sessions"
if [ "$sessions" = "No sessions available" ]; then
  echo "> openvpn3 session-start --config "$CONFIG_FILE" "$USERNAME" &>/dev/null &"
  $(openvpn3 session-start --config "$CONFIG_FILE" "$USERNAME" &>/dev/null &)
else
  while IFS= read -r path; do
      echo "> openvpn3 session-manage --disconnect --path $path"
      $(openvpn3 session-manage --disconnect --path "$path" &>/dev/null &)
  done < <( openvpn3 sessions-list | grep 'Path:' | awk '{print $2}' )
fi
