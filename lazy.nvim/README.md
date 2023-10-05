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

# To do

- LSP for different languages
  - ensure defaults for mastodon: lua, docker, typescript, linters, formatters
- Being able to select the first suggestion easily from the autocompletition tool
- Git diff? and lazy load on git command? 'cmd = "Git"'
- move keybidings for plugins to pluging definition? in that way I can remove all that I dont' want
