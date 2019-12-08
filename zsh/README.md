# zsh

`$ sudo apt install zsh`

Verify installation by running `$ zsh --version`.
Make it your default shell: `$ chsh -s $(which zsh)`

# oh-my-zsh

`sh -c "$(wget -O- https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"`

# Plugin and theme:

https://github.com/denysdovhan/spaceship-prompt
```
$ git clone https://github.com/denysdovhan/spaceship-prompt.git "$ZSH_CUSTOM/themes/spaceship-prompt"
$ ln -s "$ZSH_CUSTOM/themes/spaceship-prompt/spaceship.zsh-theme" "$ZSH_CUSTOM/themes/spaceship.zsh-theme"
```

# Plugins

## autosuggestions

`$ git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions`


