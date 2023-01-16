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

## Bluetooth 

Install bluetooth manager

```bash
sudo apt install blueman
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
- bluetooth function to install blueman
- yvpn
- gvm (golang virtual manager)
- i3 lock/suspend
- backgrounds and wallpapers
- allow laptop to run bl (alias for xbacklight and install xbacklight in the laptop, sudo apt install xbacklight)
- history-msearch-multi-word not found
- spaceceship_kubecontext_show is deprecated, use spaceship_subetl_context_show instead
- update monitors script for the laptop to:
  - set eDP-1 off when 3 monitors are set
  - set eDP-1 on when less than 3 monitors
