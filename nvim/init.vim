" VimPlug
call plug#begin(stdpath('data') . '/plugged')
Plug 'kaicataldo/material.vim'  " Material theme
Plug 'neoclide/coc.nvim', {'branch': 'release'} " Full LanguageServerProtocol
call plug#end()

let g:mapleader = "\<Space>"

" --- COLORS SCHEMA ---
" $ cp dotfiles/colors/* ~/.vim/colors/
if (has("termguicolors"))
  set termguicolors
set t_Co=256
set background=dark
colorscheme material 
" Options: 'default' | 'palenight' | 'dark'
let g:material_theme_style = 'default'

" --- VIM OPTIONS ---
set nocompatible            " disable compatibility to old-time vi
set showmatch               " show matching brackets.
" set ignorecase              " case insensitive matching
set mouse=v                 " middle-click paste with mouse
set expandtab               " converts tabs to white space
set autoindent              " indent a new line the same amount as the line just typed
set number                  " add line numbers column
set relativenumber          " realtive number line instead actual line
set wildmode=longest,list   " get bash-like tab completions
set cc=100                  " set an 80 column border for good coding style
filetype plugin indent on   " allows auto-indenting depending on file type
syntax on                   " syntax highlighting
set tabstop=2               " size of an 'indent'
set shiftwidth=2            " a combination of spaces and tabas are used to simulate tab stops at a width other than the (hard)tabstop
set softtabstop=2
set smarttab                " make 'tab' insert indents instead of tabs at the beinning fo a line
set expandtab               " always uses spaces instead of tab characters
set undofile                " Creates <FILENAME>.un~ so you can undo actions done even when you exit vim

" set dir for swap, backup and undo files. Do before:
" mkdir -p ~/.vim/{backup_files,swap_files,undo_files}
set backupdir=~/.vim/backup_files//
set directory=~/.vim/swap_files//
set undodir=~/.vim/undo_files//

" Add icon to breakline
set showbreak=↪

" Remap ESCAPE to jk for insert
inoremap jk <ESC>
inoremap JK <ESC>
" Remap ESCAPE to v for visual
vno v <ESC>
" One very useful feature of Vim is that you can set it to visually wrap long
" lines. Many users, including me, remap j/k to gj/gk to make j/k move by
" virtual lines instead of physical lines. This remapping, however, breaks the
" counting functionality described above. To remedy this, use the following
" mapping instead.
" This makes gj/gk move by virtual lines when used without a count, and by
" physical lines when used with a count. This is perfect in tandem with
" relative numbers.
noremap <silent> <expr> j (v:count == 0 ? 'gj' : 'j')
noremap <silent> <expr> k (v:count == 0 ? 'gk' : 'k')

" Set highlighting ON
set hlsearch
" Allow toogle it with <F4>
noremap <F4> :set hlsearch! hlsearch?<CR>

" define BadWhitespace before using in a match
highlight BadWhitespace ctermbg=red guibg=darkred
" Flagging unnecessary whitespace
au BufRead,BufNewFile *.py,*.pyw,*.c,*.h match BadWhitespace /\s\+$/

let python_highlight_all=1

" vimdevicons
set encoding=utf8
set guifont=UbuntuMono\ Nerd\ Font\ 10
let g:airline_powerline_fonts = 1

" :FormatJSON to use it. Requires python installed
com! FormatJSON %!python -m json.tool

" Sets the + (unnamedplus) and * (unnamed) registers to be used as ctrl+v/c
set clipboard^=unnamedplus

" Typescript autocompletition
" npm install -g typescript-language-server
