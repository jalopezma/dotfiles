# $ sudo apt install xserver-xorg-input-synaptics
#!/bin/bash

# Should return "DELL07E6:00 06CB:76AF Touchpad"
getTouchpadName() {
  touchpad=$(xinput list | grep Touchpad | awk -F '\t' '{print $1}' | awk -F '↳ ' '{print $2}')
  echo $touchpad
}

# property will be:
# 0 disabled
# 1 enabled 
# $1 argument is the device name
isTouchpadEnable() {
  touchpadStatus=$(xinput --list-props "$1" | grep "Device Enabled" | awk '{print $4}')
  if [ $touchpadStatus -eq 0 ]; then
    echo false
  else
    echo true
  fi
}

main() {
  touchpadName=$(getTouchpadName)
  echo "Touchpad name: $touchpadName"
  enable=$(isTouchpadEnable "$touchpadName")
  if $enable; then
    echo "Touchpad disabled"
    xinput disable "$touchpadName"
  else
    echo "Touchpad enabled"
    xinput enable "$touchpadName"
  fi
}

main
