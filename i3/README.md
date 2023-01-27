# i3

Path: ~/.config/i3/config

## Fonts

Download awesomefonts web version
https://github.com/FortAwesome/Font-Awesome/releases

Check fonts folder exists and move the ttf there
```
mkdir ~/.fonts
mv ~/Downloads/FontAwesome/webfonts/fa-regular-400.ttf ~/.fonts/
```
## Add swithcer on tray system

https://github.com/yktoo/indicator-sound-switcher

I need to add `exec indicator-sound-switcher` to i3status or polybar

If any inputs don't appear, run `$ pulseaudio -k`
