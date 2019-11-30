# Termite


```
sudo apt update
sudo apt install -y build-essential git g++ libgtk-3-dev gtk-doc-tools gnutls-bin valac intltool libpcre2-dev libglib3.0-cil-dev libgnutls28-dev libgirepository1.0-dev libxml2-utils gperf libtool
```

Install `vte-ng`. Dependencie needed.
```
cd ~/repos
git clone https://github.com/thestinger/vte-ng.git
echo export LIBRARY_PATH="/usr/include/gtk-3.0:$LIBRARY_PATH"
cd vte-ng/bindings/vala
vi vala.app

  // Modify line 822
  public struct Options
  {
    // To fix stupid error
    public int dummy;

./autogen.sh
make && sudo make install
```

Install termite
```
git clone --recursive https://github.com/thestinger/termite.git
cd ../termite && make && sudo make install
sudo ldconfig
sudo mkdir -p /lib/terminfo/x; sudo ln -s \
/usr/local/share/terminfo/x/xterm-termite \
/lib/terminfo/x/xterm-termite

sudo update-alternatives --install /usr/bin/x-terminal-emulator x-terminal-emulator /usr/local/bin/termite 60
```
