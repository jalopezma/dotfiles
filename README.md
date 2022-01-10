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

# Bluetooth 
The last dongle I've wasn't supported on linux.
Running `➜ sudo dmesg | grep -i blue`
Was giving 
```
[ 6799.057267] usb 5-1.3.1: Product: Bluetooth Radio
[ 6799.339736] Bluetooth: hci0: RTL: examining hci_ver=0a hci_rev=000b lmp_ver=0a lmp_subver=8761
[ 6799.340716] Bluetooth: hci0: RTL: rom_version status=0 version=1
[ 6799.340723] Bluetooth: hci0: RTL: loading rtl_bt/rtl8761b_fw.bin
[ 6799.340750] bluetooth hci0: Direct firmware load for rtl_bt/rtl8761b_fw.bin failed with error -2
[ 6799.340756] Bluetooth: hci0: RTL: firmware file rtl_bt/rtl8761b_fw.bin not found
```

So I downloaded the firmware https://linuxreviews.org/Realtek_RTL8761B and copied it to the right location

```
➜ sudo mv rtl8761b_config /lib/firmware/rtl_bt/rtl8761b_config.bin
➜ sudo mv rtl8761b_fw /lib/firmware/rtl_bt/rtl8761b_fw.bin
```
