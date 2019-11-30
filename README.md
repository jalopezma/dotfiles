# dotfiles

# VIM
.vimrc => ~/.vimrc
colors/wombat.vim => ~/.vim/colors

# GIT
.gitconfig => ~/.gitconfig

# i3

# urxvt

# scripts
```
mkdir ~/scripts
cp ~/repos/dotfiles/scripts/* ~/scripts
chmod +x ~/scripts/*.sh
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


# Walpapers
`ln -s ~/walpapers ~/repos/dotfiles/walpapers`
