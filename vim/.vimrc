set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

" The following are examples of different formats supported.
" Keep Plugin commands between vundle#begin/end.
"
" plugin on GitHub repo
Plugin 'tpope/vim-fugitive'

" The nerd tree
Plugin 'scrooloose/nerdtree'
" For nerdtree git
Plugin 'Xuyuanp/nerdtree-git-plugin'
" The nerd commenter
Plugin 'scrooloose/nerdcommenter'

" Ctrl+p => <C-p> Easy and fast way to open a file
Plugin 'kien/ctrlp.vim'

" Cool status bar
Plugin 'vim-airline/vim-airline'
" Cool status bar themes
Plugin 'vim-airline/vim-airline-themes'
" Buffer on status bar
Plugin 'bling/vim-bufferline'

" Colors solarized
"Plugin 'altercation/vim-colors-solarized'

" twig syntax
Plugin 'evidens/vim-twig'
" volt syntax
Plugin 'etaoins/vim-volt-syntax'
" less syntax
Plugin 'groenewege/vim-less'
" typescript syntax
Plugin 'leafgarland/typescript-vim'

" Javascript syntax
Plugin 'pangloss/vim-javascript'

" Php
Plugin 'StanAngeloff/php.vim'

" Autocomplete
Plugin 'Valloric/YouCompleteMe'

" Snippets
Plugin 'honza/vim-snippets'

" provides meaningful feedback about warnings and errors
Plugin 'scrooloose/syntastic'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line

" --- THE NERD TREE ---
" If not opening a file, it adds the tree
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
" Always add the tree
" autocmd vimenter * NERDTree
" CTRL+N to toggle the tree
map <C-n> :NERDTreeToggle<CR>
" Close VIM if the only left window open it's NERDTree
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif

" --- VIM-AIRLANE ---
" let g:airline_section_b = '%{strftime("%c")}'
" let g:airline_section_y = 'BN: %{bufnr("%")}'
" Fix for no color on the status bar
set t_Co=256

" --- COLORS SOLARIZED ---
"syntax enable
"set background=dark
"colorscheme solarized

" --- COLORS SOLARIZED ---
syntax on
colorscheme wombat

" --- THE NERD COMMENTER ---
filetype plugin on

" --- INDENTATION ---
" size of a hard tabstop
set tabstop=4
"size of an 'indent'
set shiftwidth=4
" a combination of spaces and tabas are used to simulate tab stops at a width
" other than the (hard)tabstop
set softtabstop=4
" make 'tab' insert indents instead of tabs at the beinning fo a line
set smarttab
" always uses spaces instead of tab characters
set expandtab
" set number lines
set number

" set dir for swap, backup and undo files. Do before:
" mkdir -p ~/.vim/{backup_files,swap_files,undo_files}
set backupdir=~/.vim/backup_files//
set directory=~/.vim/swap_files//
set undodir=~/.vim/undo_files//

" vim-airline
" vim-airline => Fix symbols on airline
" Install https://github.com/powerline/fonts ./install.sh
" Select dejavu font on terimnal
let g:airline_powerline_fonts = 1

if !exists('g:airline_symbols')
    let g:airline_symbols = {}
endif

" unicode symbols
let g:airline_left_sep = '»'
let g:airline_left_sep = '▶'
let g:airline_right_sep = '«'
let g:airline_right_sep = '◀'
let g:airline_symbols.linenr = '␊'
let g:airline_symbols.linenr = '␤'
let g:airline_symbols.linenr = '¶'
let g:airline_symbols.branch = '⎇'
let g:airline_symbols.paste = 'ρ'
let g:airline_symbols.paste = 'Þ'
let g:airline_symbols.paste = '∥'
let g:airline_symbols.whitespace = 'Ξ'

" airline symbols
let g:airline_left_sep = ''
let g:airline_left_alt_sep = ''
let g:airline_right_sep = ''
let g:airline_right_alt_sep = ''
let g:airline_symbols.branch = ''
let g:airline_symbols.readonly = ''
let g:airline_symbols.linenr = ''

" airline not showing
set laststatus=2
set ttimeoutlen=50
let g:airline_symbols.linenr = ''

" Php.vim hightlight phpdoctags
function! PhpSyntaxOverride()
    hi! def link phpDocTags  phpDefine
    hi! def link phpDocParam phpType
endfunction

augroup phpSyntaxOverride
    autocmd!
    autocmd FileType php call PhpSyntaxOverride()
augroup END

" YouCompleteMe Typescript
if !exists("g:ycm_semantic_triggers")
  let g:ycm_semantic_triggers = {}
endif
let g:ycm_semantic_triggers['typescript'] = ['.']

" scrooloose/syntastic
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

" Ctrlp ignore files in .gitignore
let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files -co --exclude-standard']
