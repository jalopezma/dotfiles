Path: ~/.config/i3/config
`ln -s ~/repos/dotfiles/i3/config ~/.config/i3/config`

Download awesomefonts web version
https://github.com/FortAwesome/Font-Awesome/releases


Check fonts folder exists and move the ttf there
```
mkdir ~/.fonts
mv ~/Downloads/FontAwesome/webfonts/fa-regular-400.ttf ~/.fonts/
```

Background:
`$ sudo apt install feh`
https://faq.i3wm.org/question/6247/assigning-individual-wallpaper-to-monitors.1.html

change dmenu by rofi
`$ sudo apt install rofi`

for enable opacity. Not working with rofi right now. Have to check it.
`$ sudo apt install compton`


to change audio settings
`$ sudo apt install pavucontrol`
to run 
`$ pavucontrol`

# betterlockscreen
for lock user:
https://github.com/pavanjadhaw/betterlockscreen

needs to install i3lock-colors

## i3lock-colors

```
$ cd ~/repos
$ g clone https://github.com/PandorasFox/i3lock-color
$ cd i3lock-color

$ autoreconf --force --install

$ rm -rf build/
$ mkdir -p build && cd build/

$ ../configure \
  --prefix=/usr \
  --sysconfdir=/etc \
  --disable-sanitizers

$ make

# Probably you will need to rename i3lock
$ sudo mv /usr/bin/i3lock /usr/bin/i3lock-original
$ sudo ln -s ~/repos/i3lock-color/build/i3lock /usr/bin/i3lock
```

list to install:

```
sudo apt install libev-dev \
      libxcb-composite0 \
      libxcb-composite0-dev \
      libxcb-xinerama0 \
      libxcb-randr0 \
      libxcb-xinerama0-dev \
      libxcb-xkb-dev \
      libxcb-image0-dev \
      libxcb-util-dev \
      libxkbcommon-x11-dev \
      libjpeg-turbo8-dev \
      libpam0g-dev \
      pkg-config \
      xcb-proto \
      libxcb-xrm-dev \
      libxcb-randr0-dev \
      libxkbcommon-dev \
      libcairo2-dev \
      libxcb1-dev \
      libxcb-dpms0-dev \
      libxcb-image0-dev \
      libxcb-util0-dev \
      libev-dev \
      libxcb-xinerama0-dev \
      libxcb-xkb-dev
```

# Add swithcer on tray system
https://github.com/yktoo/indicator-sound-switchersound

I need to add `exec indicator-sound-switcher` to i3status or polybar

If any inputs don't appear, run `$ pulseaudio -k`


Bluetooth applet: `sudo apt install blueman` and then run `blueman-applet`

To do:
- map resize
- colors of borders
- use i3blocks or polybar
- check why workspace icons doesn't work
