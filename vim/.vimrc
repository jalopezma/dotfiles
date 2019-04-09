set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
" call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

" Monokai color scheme
Plugin 'crusoexia/vim-monokai'

" plugin on GitHub repo
Plugin 'tpope/vim-fugitive'
" plubing for git -> see if column has been changed
Plugin 'airblade/vim-gitgutter'

" The nerd tree
Plugin 'scrooloose/nerdtree'
" For nerdtree git
Plugin 'Xuyuanp/nerdtree-git-plugin'
" The nerd commenter
Plugin 'scrooloose/nerdcommenter'
" nerd ignore different for projects
Plugin 'dsimidzija/vim-nerdtree-ignore'

" Cool status bar
Plugin 'vim-airline/vim-airline'
" Cool status bar themes
Plugin 'vim-airline/vim-airline-themes'

" less syntax
Plugin 'groenewege/vim-less'

" typescript syntax
Plugin 'leafgarland/typescript-vim'
" Javascript syntax
Plugin 'pangloss/vim-javascript'

" Autocomplete
Plugin 'Valloric/YouCompleteMe'

" tsc checker removed from syntastic, get it from here
Plugin 'Quramy/tsuquyomi'
" required by Quramy/tsuquyomi
Plugin 'Shougo/vimproc.vim'

" Go
Plugin 'fatih/vim-go'

" Bookmarks
" Add/remove bookmark at current line           mm  :BookmarkToggle
" Add/edit/remove annotation at current line    mi  :BookmarkAnnotate <TEXT>
" Jump to next bookmark in buffer               mn  :BookmarkNext
" Jump to previous bookmark in buffer           mp  :BookmarkPrev
" Show all bookmarks (toggle)                   ma  :BookmarkShowAll
" Clear bookmarks in current buffer only        mc  :BookmarkClear
" Clear bookmarks in all buffers                mx  :BookmarkClearAll
" Move up bookmark at current line              mkk :BookmarkMoveUp
" Move down bookmark at current line            mjj :BookmarkMoveDown
" Save all bookmarks to a file                      :BookmarkSave <FILE_PATH>
" Load bookmarks from a file                        :BookmarkLoad <FILE_PATH>
Plugin 'MattesGroeger/vim-bookmarks'

" EditorConfig
Plugin 'editorconfig/editorconfig-vim'

" Clang Format (for typescript)
Plugin 'primitivorm/vim-clang-format'

" Adds background with the color for hexa, name and rgb colors
Plugin 'ap/vim-css-color'

" Surrounding braces, quotes and other things
Plugin 'tpope/vim-surround'

" Right tag bar. Structure of the file
Plugin 'majutsushi/tagbar'

" Vim dev icons
" Needs https://github.com/ryanoasis/nerd-fonts/blob/master/patched-fonts/UbuntuMono/Regular/complete/Ubuntu%20Mono%20Nerd%20Font%20Complete.ttf
" make ~/.fonts and move the font there
Plugin 'ryanoasis/vim-devicons'

" Asynchronous Lint Engine
Plugin 'w0rp/ale'

" Auto pairs for [({
Plugin 'jiangmiao/auto-pairs'

" fzf for vin
Plugin 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plugin 'junegunn/fzf.vim'

" xolox/vim-easytags, xolox/vim-misc - Creates tags on save
Plugin 'xolox/vim-easytags'
Plugin 'xolox/vim-misc'

" <leader>gh to open the link to current line at github (Also support Bitbucket and self deployed gitlab)
Plugin 'ruanyl/vim-gh-line'

" This plugin highlights patterns and ranges for Ex commands in Command-line mode.
Plugin 'markonm/traces.vim'

" Haskell devtools
Plugin 'bitc/vim-hdevtools'

" Material theme
""Plugin 'hzchirs/vim-material'
Plugin 'kaicataldo/material.vim'

" Uses the same key bidings that tmux to move through splits
" Plugin 'christoomey/vim-tmux-navigator'

" Highlights comments
" Plugin 'jbgutierrez/vim-better-comments'

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

let mapleader = "\<Space>"

" --- THE NERD TREE ---
" If not opening a file, it adds the tree
"autocmd StdinReadPre * let s:std_in=1
"autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
" Always add the tree
" autocmd vimenter * NERDTree
" CTRL+N to toggle the tree
map <C-n> :NERDTreeToggle<CR>
" Close VIM if the only left window open it's NERDTree
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif
" Hide .pyc files
let NERDTreeIgnore=['\.pyc$', '\~$']
let NERDTreeShowHidden=1

" --- THE NERD COMMENTER ---
filetype plugin on
" Add spaces after comment delimiters by default
let g:NERDSpaceDelims = 1
" Allow commenting and inverting empty lines (useful when commenting a region)
let g:NERDCommentEmptyLines = 1
" Enable trimming of trailing whitespace when uncommenting
let g:NERDTrimTrailingWhitespace = 1

" --- COLORS SCHEMA ---
" $ cp dotfiles/colors/* ~/.vim/colors/
syntax on
set termguicolors
set t_Co=256

" colorscheme monokai
" colorscheme dank-neon
" colorscheme wombat
" colorscheme atom-one-dark

set background=dark
" colorscheme kuroi

" Material - Palenight
" Needs urxvt to work properly I think
" set background=dark
" let g:material_style='oceanic'
" colorscheme vim-material


" Another material
" kaicataldo/material.vim
colorscheme material 
" let g:material_theme_style = 'default' | 'palenight' | 'dark'
let g:material_theme_style = 'dark'
let g:airline_theme = 'material'

" solarized
" set background=dark
" colorscheme solarized

" --- VIM-AIRLANE ---
" Fix for no color on the status bar
" vim-airline => Fix symbols on airline
" Use font from vimdevicons patched
let g:airline_powerline_fonts = 1
" airline not showing
set laststatus=2
set ttimeoutlen=50

" --- bitc/vim-hdevtools ---
" Make use stack
let g:hdevtools_stack = 1
" Haskell expressions can be typechecked even if type errors elsewhere in the project 
let g:hdevtools_options = '-g-fdefer-type-errors'
au FileType haskell nnoremap <buffer> <F1> :HdevtoolsType<CR>
au FileType haskell nnoremap <buffer> <silent> <F2> :HdevtoolsInfo<CR>
au FileType haskell nnoremap <buffer> <silent> <F3> :HdevtoolsClear<CR>

" --- Valloric/YouCompleteMe ---
" Hide preview window
"set completeopt-=preview
let g:ycm_autoclose_preview_window_after_completion=1
" map <leader>g  :YcmCompleter GoToDefinitionElseDeclaration<CR>

" --- pangloss/vim-javascript ---
let g:javascript_conceal_function       = "ƒ"
let g:javascript_conceal_null           = "ø"
let g:javascript_conceal_this           = "@"
let g:javascript_conceal_return         = "⇚"
let g:javascript_conceal_undefined      = "¿"
let g:javascript_conceal_NaN            = "ℕ"
let g:javascript_conceal_prototype      = "¶"
let g:javascript_conceal_static         = "•"
let g:javascript_conceal_super          = "Ω"
let g:javascript_conceal_arrow_function = "⇒"

" --- vim-go ---
" #Enable syntax-hightlighting for Functions, Methods and Structs
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_fields = 1
let g:go_highlight_types = 1
let g:go_highlight_operators = 1
let g:go_highlight_build_constraints = 1
" Enable goimports to automatically insert import paths instead of gofmt:
let g:go_fmt_command = "goimports"
" #Map :GoDef to 'gd' secuence
au FileType go nmap gd <Plug>(go-def)
au FileType go nmap ld :GoDecls<ENTER>
" Executes GoInstallBinaries at the begining
autocmd VimEnter * GoInstallBinaries

" --- editor config ---
let g:EditorConfig_exclude_patterns = ['fugitive://.*']

" --- w0rp/ale --- | Asynchronous Lint Engine
" Opens the local list window with the errors
"let g:ale_open_list = 1
"let g:ale_list_window_size = 5
" Shows the left gutter always so text is being pushed and pulled
let g:ale_sign_column_always = 1
" Show errors count on airline
let g:airline#extensions#ale#enabled = 1
" Run lint on changes only for normal mode (undo, redo)
let g:ale_lint_on_text_changed = 'normal'
" Run lint on leave insert, save and enter file. Last two are 1 by default
let g:ale_lint_on_insert_leave = 1
let g:ale_lint_on_save = 1
let g:ale_lint_on_enter = 1
nmap gd :ALEGoToDefinition<ENTER>
nmap gD :ALEGoToDefinitionInTab<ENTER>
" Open same file at right split, go there and go to the definition
nmap gds :vsplit<ENTER><C-w><Right>:ALEGoToDefinition<ENTER>
nmap gr :ALEFindReferences<ENTER>

" --- fzf.vim --- https://jesseleite.com/posts/2/its-dangerous-to-vim-alone-take-faa
" *File finder
" Search for git tracked files
nmap <Leader>f :GFiles<CR>
" Search all files
nmap <Leader>F :Files<CR>
" Search for open buffers
nmap <Leader>b :Buffers<CR>
" Search in history
nmap <Leader>h :History<CR>
" Goes to selected window
nmap <Leader>w :Windows<CR>

" *Tag finder
" Search for tags in the open buffers
nmap <Leader>t :BTags<CR>
" Search for global tags
nmap <Leader>T :Tags<CR>

" *Line finder 
" on current buffer
nmap <Leader>l :BLines<CR>
" loaded buffers
nmap <Leader>L :Lines<CR>
" marked lines
nmap <Leader>' :Marks<CR>

" *Project finder
" Requires to install https://github.com/ggreer/the_silver_searcher manually.
" Allows to search on the project
nmap <Leader>a :Ag<Space>

" ruanyl/vim-gh-line - Go to github url
let g:gh_line_map = '<Leader>gh'

" --- VIM OPTIONS ---
" size of a hard tabstop
set tabstop=2
"size of an 'indent'
set shiftwidth=2
" a combination of spaces and tabas are used to simulate tab stops at a width
" other than the (hard)tabstop
set softtabstop=2
" make 'tab' insert indents instead of tabs at the beinning fo a line
set smarttab
" always uses spaces instead of tab characters
set expandtab
" set number lines show the col with the numbers. set relativenumbers show the
" number of lines from your current line. Both togeter show the relative lines
" numbers and the number line where you are.
set number
set relativenumber
" Creates <FILENAME>.un~ so you can undo actions done even when you exit vim
set undofile

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

" Pyhton
" ------
" This will give you the standard four spaces when you hit tab, ensure your
" line length doesn’t go beyond 80 characters, and store the file in a unix
" format so you don’t get a bunch of conversion issues when checking into
" GitHub and/or sharing with other users.
au BufNewFile,BufRead *.py
    \ set tabstop=4 |
    \ set softtabstop=4 |
    \ set shiftwidth=4 |
    \ set textwidth=79 |
    \ set expandtab |
    \ set autoindent |
    \ set fileformat=unix

" define BadWhitespace before using in a match
highlight BadWhitespace ctermbg=red guibg=darkred
" Flagging unnecessary whitespace
au BufRead,BufNewFile *.py,*.pyw,*.c,*.h match BadWhitespace /\s\+$/

let python_highlight_all=1

" majutsushi/tagbar 
" -----------------
nmap <F3> :TagbarToggle<CR>
let g:tagbar_type_typescript = {                                                  
    \ 'ctagsbin' : 'tstags',
    \ 'ctagsargs' : '-f-',
    \ 'kinds': [
        \ 'e:enums:0:1',
        \ 'f:function:0:1',
        \ 't:typealias:0:1',
        \ 'M:Module:0:1',
        \ 'I:import:0:1',
        \ 'i:interface:0:1',
        \ 'C:class:0:1',
        \ 'm:method:0:1',
        \ 'p:property:0:1',
        \ 'v:variable:0:1',
        \ 'c:const:0:1',
    \ ],
    \ 'sort' : 0
\ }

let g:tagbar_type_go = {
    \ 'ctagstype' : 'go',
    \ 'kinds'     : [
        \ 'p:package',
        \ 'i:imports:1',
        \ 'c:constants',
        \ 'v:variables',
        \ 't:types',
        \ 'n:interfaces',
        \ 'w:fields',
        \ 'e:embedded',
        \ 'm:methods',
        \ 'r:constructor',
        \ 'f:functions'
    \ ],
    \ 'sro' : '.',
    \ 'kind2scope' : {
        \ 't' : 'ctype',
        \ 'n' : 'ntype'
    \ },
    \ 'scope2kind' : {
        \ 'ctype' : 't',
        \ 'ntype' : 'n'
    \ },
    \ 'ctagsbin'  : 'gotags',
    \ 'ctagsargs' : '-sort -silent'
\ }

" vimdevicons
set encoding=utf8
set guifont=UbuntuMono\ Nerd\ Font\ 10
let g:airline_powerline_fonts = 1

" :FormatJSON to use it. Requires python installed
com! FormatJSON %!python -m json.tool
