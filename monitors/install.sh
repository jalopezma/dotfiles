#!/bin/bash
verbose=false
logFolder=/tmp/jalopezma-install
logFile="$logFolder/install.log"

setLogFile() {
  if [ ! -d "$logFolder" ]; then
    mkdir $logFolder
  fi

  if [ ! -f "$logFile" ]; then
    touch $logFile
  fi

  echo "$(date)" >> $logFile
}

# Helps to print the output of the command if the verbose flag is set
run() {
  local output=$1
  local verbose=${2:-false}
  if $verbose; then
    echo "$output"
  fi
  echo "$output" >> $logFile
}

# Prints to stdout and log file
print() {
  echo "$1"
  echo "$1" >> $logFile
}

createSymlink() {
  local from=$1
  local to=$2
  local sudo=${3:-false}
  if [ -f $to ] || [ -d $to ]; then
    echo "[monitors] File $to already exists"
  else
    if $sudo; then
      run "$(sudo ln -s $from $to)" $verbose
    else
      run "$(ln -s $from $to)" $verbose
    fi
  fi
}

print "[monitors] install jq"
run "$(sudo apt-get install jq -y)"

print "[monitors] Link udev rules"
createSymlink ~/repos/dotfiles/monitors/99-monitors-hotplug.rules /etc/udev/rules.d/99-monitors-hotplug.rules true
run "$(sudo chmod 0644 /etc/udev/rules.d/99-monitors-hotplug.rules)"
# run "$(touch /tmp/scripts.log && chmod 644 /tmp/scripts.log)"
print "[monitors] Reload udev rules"
run "$(sudo udevadm control --reload-rules)"

print "[monitors] Link monitor service"
run "$(sed -i "s/<user>/"$(whoami)"/g" ~/repos/dotfiles/monitors/monitors.service)"
createSymlink ~/repos/dotfiles/monitors/monitors.service /etc/systemd/system/monitors.service true
print "[monitors] Reload service daemon"
run "$(systemctl daemon-reload)"
