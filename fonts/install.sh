#/bin/bash
# install UbuntuMono Nerd Font from https://www.nerdfonts.com/font-downloads

echo "[fonts] Copy stored fonts"
mkdir -p ~/.local/share/fonts
cp ./fonts/*.ttf ~/.local/share/fonts/

echo "[fonts] Download UbuntuMono font"
wget -q -O /tmp/fonts.zip https://github.com/ryanoasis/nerd-fonts/releases/download/v3.0.2/UbuntuMono.zip
unzip -qq -o /tmp/fonts.zip -d ~/.local/share/fonts/
fc-cache -fv &> /dev/null
echo "[fonts] exit"
