# NeoVim

## Install NeoVim

The [./install.sh](./install.sh) script should take care of this for you.

You might want to install the latest neovim version that is still not in the ubuntu package manager. [github releases](https://github.com/neovim/neovim/releases/)
Follow the steps there but you will probably need to do the following (if you installed nvim from the ubuntu package manager before)

How to get an appimage from releases

```console
curl -o /tmp/nvim -sLO https://github.com/neovim/neovim/releases/latest/download/nvim.appimage &> /dev/null
chmod u+x /tmp/nvim
sudo mv /tmp/nvim /usr/local/bin/nvim
```

Install Neovim and python

```console
sudo apt-get install python-neovim python3-neovim
```

## Lazy.nvim

`:Lazy`

### Uninstall

Remove the data, state folders and lockfile.

```
data: ~/.local/share/nvim/lazy
state: ~/.local/state/nvim/lazy
lockfile: ~/.config/nvim/lazy-lock.json
```

### which-keys

`'` lists buffers
`"` lists registers (you can do `"<register>p` to paste it)
`z=` spelling suggestions

### Mason

`:Mason`

Install the required lsp, linter or formatters you need. Examples:

Linters:
- eslint_d (daemon)

Lsp
- lua-language-server
- python-lsp-server pylsp
- typescript-language-server tsserver

Formatter
- prettierd (daemon)
- black
- autopep8

# Doing

# To do
- LSP for different languages
  - ensure defaults for mastodon: lua, docker, typescript, linters, formatters
- LSP `gD` go to defintiion in a new tab
  - not sure if I want this. I can go to the definition in a new buffer and then either close it or change back
