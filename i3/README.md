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

for lock user:
https://github.com/pavanjadhaw/betterlockscreen

needs to install i3lock-colors manually from github and create a symbolic link:
`ln -s ~/repos/i3lock-color/x86_64-pc-linux-gnu/i3lock /usr/bin/i3lock`

list to install:
`sudo apt install libxcb-xinerama0-dev libxcb-xkb-dev libxcb-image0-dev libxcb-util-dev libxkbcommon-x11-dev libjpeg-turbo8-dev libpam0g-dev`

To do:
- map resize
- colors of borders
- use i3blocks or polybar
- check why workspace icons doesn't work
