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

/usr/share/X11/xorg.conf.d/40-libinput.conf

Section "InputClass"
        Identifier "libinput touchpad catchall"
        MatchIsTouchpad "on"
        MatchDevicePath "/dev/input/event*"
        Driver "libinput"
        Option "Tapping" "True"
        Option "DisableWhileTyping" "True"
        Option "NaturalScrolling" "True"
EndSection


# Wallpapers
`ln -s ~/repos/dotfiles/wallpapers ~/wallpapers`

# Device
In the `.zshrc` file we are checking the hostname to detect which computer we are in.
So far we are going to differentiate between `LAPTOP` and `DESKTOP` in the var `COMPUTER`.
