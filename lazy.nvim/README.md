# NeoVim
Install Neovim and python
`sudo apt-get install neovim python-neovim python3-neovim`

## Lazy.nvim

`:Lazy`

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
