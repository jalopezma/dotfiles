Install neovim and python
`sudo apt-get install neovim python-neovim python3-neovim`

Folder `~/.config/nvim`
Config `~/.config/nvim/init.vim`
`ln -s ~/repos/dotfiles/nvim ~/.config/nvim`

Install VimPlug for NeoVim
https://github.com/junegunn/vim-plug

```
curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
```


Use nvm 10. 
npm install -g neovim typescript-language-server

Run `:checkhealth` to see if everything is ok

// still to check
https://github.com/neoclide/coc.nvim
https://www.freecodecamp.org/news/a-guide-to-modern-web-development-with-neo-vim-333f7efbf8e2/
https://facebook.github.io/watchman/docs/install.html
https://medium.com/better-programming/setting-up-neovim-for-web-development-in-2020-d800de3efacd
https://github.com/neoclide/coc-lists

Still to add:
- change deonite for fzf?
- put backup, undo and swap in new neovim file
- change colorscheme so it's not that white the normal text in neovim

// After installing :PlugInstall
cp ~/.config/nvim/space.vim ~/.config/nvim/plugged/vim-airline-themes/autoload/airline/themes/space.vim


Crash nvim sometimes (khaleesi-tag folder) because of airline and fugitive
let g:airline_powerline_fonts = 1

go to definition open split
go to definition open tab

`➜ nvim +PlugInstall +PlugUpdate +PlugUpgrade`
