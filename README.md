# dotfiles

## Install script bash version

Run to install it

```bash
# From master
bash -c "$(wget -q -O- https://raw.githubusercontent.com/jalopezma/dotfiles/master/install.sh)"
# From "add-install-script" branch
bash -c "$(wget -q -O- https://raw.githubusercontent.com/jalopezma/dotfiles/add-install-script/install.sh)"
bash -c "$(wget -q -O- https://raw.githubusercontent.com/jalopezma/dotfiles/add-install-script/install.sh)" "" -v
```

## Install script hush version
```bash
bash -c "$(wget -q -O- https://raw.githubusercontent.com/jalopezma/dotfiles/feat/move-bash-to-hush/install-2.sh)"
```

## [Hush](hush/README.md)

## [NeoVim](nvim/README.md)

## [Git](git/README.md)

## [i3](i3/README.md)

## scripts

```bash
mkdir ~/scripts
ln -s ~/repos/dotfiles/scripts ~/scripts
```

## dell touchpad

`/usr/share/X11/xorg.conf.d/40-libinput.conf`

```
Section "InputClass"
        Identifier "libinput touchpad catchall"
        MatchIsTouchpad "on"
        MatchDevicePath "/dev/input/event*"
        Driver "libinput"
        Option "Tapping" "True"
        Option "DisableWhileTyping" "True"
        Option "NaturalScrolling" "True"
EndSection
```

## Wallpapers
`ln -s ~/repos/dotfiles/wallpapers ~/wallpapers`

## Device
In the `.zshrc` file we are checking the `hostname` to detect which computer we are in.
So far we are going to differentiate between `LAPTOP` and `DESKTOP` in the var `COMPUTER`.

## Monitors
In `monitors/99-monitors-hotplug.rules` we have defined a rule to restart service when there are changes in the monitors connected.
It seems the `add` and `remove` actions are not triggering what I want and only the `change` does it.

```bash
sudo ln -s ~/repos/dotfiles/monitors/99-monitors-hotplug.rules /etc/udev/rules.d/99-monitors-hotplug.rules
sudo chmod 0644 /etc/udev/rules.d/99-monitors-hotplug.rules
touch /tmp/scripts.log && chmod 644 /tmp/scripts.log
sudo udevadm control --reload-rules 
```

You should have already linked the `monitors.sh` script in the `~/scripts/` folder.
```bash
ln -s ~/repos/dotfiles/scripts/monitors.sh ~/scripts/monitors.sh
```

You will also need to set the monitor service. I had to use a service as the udev rule is executing the script as `root` and that breaks the init of polybar.
```bash
sudo ln -s ~/repos/dotfiles/monitors/monitors.service /etc/systemd/system/monitors.service
systemctl daemon-reload
```

## Bluetooth 
The last dongle I've wasn't supported on linux.
Running `➜ sudo dmesg | grep -i blue`
Was giving 
```
[ 6799.057267] usb 5-1.3.1: Product: Bluetooth Radio
[ 6799.339736] Bluetooth: hci0: RTL: examining hci_ver=0a hci_rev=000b lmp_ver=0a lmp_subver=8761
[ 6799.340716] Bluetooth: hci0: RTL: rom_version status=0 version=1
[ 6799.340723] Bluetooth: hci0: RTL: loading rtl_bt/rtl8761b_fw.bin
[ 6799.340750] bluetooth hci0: Direct firmware load for rtl_bt/rtl8761b_fw.bin failed with error -2
[ 6799.340756] Bluetooth: hci0: RTL: firmware file rtl_bt/rtl8761b_fw.bin not found
```

So I downloaded the firmware [https://linuxreviews.org/Realtek_RTL8761B](https://linuxreviews.org/Realtek_RTL8761B) and copied it to the right location

```bash
sudo mv rtl8761b_config /lib/firmware/rtl_bt/rtl8761b_config.bin
sudo mv rtl8761b_fw /lib/firmware/rtl_bt/rtl8761b_fw.bin
```

## Docker

Docker image to test the install script
```bash
docker build . -t ubuntu-test && docker run --rm -it --user 1000:1000 ubuntu-test
```

## Brightness

To be able to run

```bash
xbacklight 100
bl 100 # zsh alias
```

You will need to add the user to the video group

```bash
sudo usermod -a -G video $LOGNAME
# Then you can log out and in or just run
su - <user>
```

## List of things to add to auto-install

- [Pyenv](https://github.com/pyenv/pyenv)
- [Obsidian](https://obsidian.md/)
- ssh: keys and agent?
- aws credentials?
- bluetooth?
- yvpn
- gvm (golang virtual manager)
