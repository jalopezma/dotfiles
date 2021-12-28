# dotfiles

# VIM
.vimrc => ~/.vimrc
colors/wombat.vim => ~/.vim/colors

#[NeoVim](nvim/README.md)

# GIT
.gitconfig => ~/.gitconfig

# i3

# scripts
```
mkdir ~/scripts
ln -s ~/repos/dotfiles/scripts ~/scripts
```

# dell touchpad

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

# Wallpapers
`ln -s ~/repos/dotfiles/wallpapers ~/wallpapers`

# Device
In the `.zshrc` file we are checking the `hostname` to detect which computer we are in.
So far we are going to differentiate between `LAPTOP` and `DESKTOP` in the var `COMPUTER`.

# Monitors

In `monitors/99-monitors-hotplug.rules` we have defined a rule to restart service when there are changes in the monitors connected.
It seems the `add` and `remove` actions are not triggering what I want and only the `change` does it.

```
sudo ln -s /home/joselopez/repos/dotfiles/monitors/99-monitors-hotplug.rules /etc/udev/rules.d/99-monitors-hotplug.rules
sudo chmod 0644 /etc/udev/rules.d/99-monitors-hotplug.rules
touch /tmp/scripts.log && sudo chmod 666 /tmp/scripts.log
sudo udevadm control --reload-rules 
```

You should have already linked the `monitors.sh` script in the `~/scripts/` folder.
```
ln -s ~/repos/dotfiles/scripts/monitors.sh ~/scripts/monitors.sh
```

You will also need to set the monitor service. I had to use a service as the udev rule is executing the script as `root` and that breaks the init of polybar.
```
sudo ln -s /home/joselopez/repos/dotfiles/monitors/monitors.service /etc/systemd/system/monitors.service
systemctl daemon-reload
```
