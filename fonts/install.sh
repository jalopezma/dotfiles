#/bin/bash
# install UbuntuMono Nerd Font from https://www.nerdfonts.com/font-downloads
echo "[-] Download fonts [-]"
fontFile="UbuntuMono.zip"
ubuntuFonts="https://github.com/ryanoasis/nerd-fonts/releases/download/v3.0.2/$ubuntFile"
echo "$ubuntuFonts"
wget $ubuntuFonts
unzip $fontFile -d ~/.fonts
fc-cache -fv
echo "done!"
