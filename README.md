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

All scripts are formatted using [https://github.com/mvdan/sh](shfmt)

```bash
# Install
go install mvdan.cc/sh/v3/cmd/shfmt@latest
# Use
shfmt --find ./ | xargs shfmt -l -w -s --indent=2 -ci -sr
```

# To add
- [pyenv](https://github.com/pyenv/pyenv#automatic-installer)
- [gvm](https://github.com/moovweb/gvm)
- [Obsidian](https://obsidian.md/)
- i3 lock/suspend
- backgrounds and wallpapers
- allow laptop to run bl (alias for xbacklight and install xbacklight in the laptop, sudo apt install xbacklight)
- update monitors script for the laptop to:
  - set eDP-1 off when 3 monitors are set
  - set eDP-1 on when less than 3 monitors

## [Hush](hush/README.md)

## [NeoVim](nvim/README.md)

## [Git](git/README.md)

## [i3](i3/README.md)

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

## Device
In the `.zshrc` file we are checking the `hostname` to detect which computer we are in.
So far we are going to differentiate between `LAPTOP` and `DESKTOP` in the var `COMPUTER`.

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

## Yieldify

- OpenVPN
  - [Installation](https://community.openvpn.net/openvpn/wiki/OpenVPN3Linux?_ga=2.225757343.406983588.1673944046-2138455025.1673944046) 
- Faceless
- Kubernetes
