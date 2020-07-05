#!/bin/sh
echo > $HOME/repos/dotfiles/i3/config && # empty the current config file
for f in $HOME/repos/dotfiles/i3/i3.*; do (cat "${f}"; echo) >> $HOME/repos/dotfiles/i3/config; done && # cat every file and add a new line every file and append everything to the config file
i3-msg reload # Restart the window manager
i3-msg restart # Restart the window manager
