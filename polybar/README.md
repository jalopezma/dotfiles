# Polybar

cd ~/repos
g clone https://github.com/polybar/polybar.git
apt install build-essential git cmake cmake-data pkg-config python3-sphinx libcairo2-dev libxcb1-dev libxcb-util0-dev libxcb-randr0-dev libxcb-composite0-dev python-xcbgen xcb-proto libxcb-image0-dev libxcb-ewmh-dev libxcb-icccm4-dev libasound2-dev libcurl4-openssl-dev ccache libmpdclient-dev libiw-dev libpulse-dev libxcb-xkb-dev libxcb-xrm-dev libxcb-cursor-dev libasound2-dev libpulse-dev i3-wm libjsoncpp-dev libnl-genl-3-dev python3-xcbgen

cd poybar
./build.sh

$ install -Dm644 /usr/local/share/doc/polybar/config $HOME/.config/polybar/config
$ polybar example

Theme from https://github.com/adi1090x/polybar-themes.git


`$ ln -s ~/repos/dotfiles/polybar ~/.config/polybar`

Not sure if I have to run this:
```
$ chmod +x $HOME/.config/polybar/launch.sh
```

This needs to go to i3 config file (it should be there already)
`exec_always --no-startup-id $HOME/.config/polybar/launch.sh`

To debug with font issues you can use

```
$ fc-list | grep <name>
$ fc-match <name that you found>
```
