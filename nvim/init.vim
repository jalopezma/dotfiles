" VimPlug
call plug#begin()
" Material theme
Plug 'kaicataldo/material.vim'
" Full LanguageServerProtocol
Plug 'neoclide/coc.nvim', {'branch': 'release'}
" TS TSX and JSX suuport
Plug 'leafgarland/typescript-vim'
Plug 'peitalin/vim-jsx-typescript'
" Git
Plug 'tpope/vim-fugitive'
" Git, add column with status if line has been changed
Plug 'mhinz/vim-signify'
" Status bar
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
" Moving shortcuts/motions: <Leader><Leader>s{char} -> {target-chars}
Plug 'easymotion/vim-easymotion'
" Nerdtree - side tree explorer
Plug 'scrooloose/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'
" Icons
Plug 'ryanoasis/vim-devicons'
Plug 'tiagofumo/vim-nerdtree-syntax-highlight'
call plug#end()

let g:mapleader = "\<Space>"

" --- COLORS SCHEMA ---
if (has('termguicolors'))
  set termguicolors
endif

set t_Co=256
set background=dark
colorscheme material 
" Options: 'default' | 'palenight' | 'ocean' | 'lighter' | 'darker'
let g:material_theme_style = 'default'
let g:airline_theme = 'space'

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

" Set space for displaying messages.
set cmdheight=1

" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=300

" Don't pass messages to |ins-completion-menu|.
set shortmess+=c

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
set signcolumn=yes

" Set highlighting ON
set hlsearch
" Allow toogle it with <F4>
noremap <F4> :set hlsearch! hlsearch?<CR>

" define BadWhitespace before using in a match
highlight BadWhitespace ctermbg=red guibg=darkred
" Flagging unnecessary whitespace
au BufRead,BufNewFile *.py,*.pyw,*.c,*.h match BadWhitespace /\s\+$/
let python_highlight_all=1

" :FormatJSON to use it. Requires python installed
com! FormatJSON %!python -m json.tool

" Sets the + (unnamedplus) and * (unnamed) registers to be used as ctrl+v/c
set clipboard^=unnamedplus

" --- VIMDEVICONS ---
" vimdevicons
set encoding=utf8
"set guifont=UbuntuMono\ Nerd\ Font\ 10
" It's failing because of the following line. dunno
"let g:airline_powerline_fonts = 1

" --- neoclide/coc.nvim ---
" Typescript autocompletition
" npm install -g typescript-language-server

" Set extensions
let g:coc_global_extensions = ['coc-css', 'coc-html', 'coc-json', 'coc-tsserver', 'coc-python', 'coc-eslint', 'coc-git', 'coc-yank', 'coc-pairs', 'coc-highlight']
" config file uses jsonc
autocmd FileType json syntax match Comment +\/\/.\+$+

" --- coc.nvim extensions ---
" coc-yank - :CocCommand yank.clean - to clean
nnoremap <silent> <space>y  :<C-u>CocList -A --normal yank<cr>

" --- peitalin/vim-jsx-typescript ---
" set filetypes as typescript.tsx
autocmd BufNewFile,BufRead *.tsx,*.jsx set filetype=typescript.tsx

" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current
" position. Coc only does snippet and additional edit on confirm.
if has('patch8.1.1068')
  " Use `complete_info` if your (Neo)Vim version supports it.
  inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"
else
  imap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
endif

" Use `[g` and `]g` to navigate diagnostics
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder.
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

function! StatusDiagnostic() abort
  let info = get(b:, 'coc_diagnostic_info', {})
  if empty(info) | return '' | endif
  let msgs = []
  if get(info, 'error', 0)
    call add(msgs, 'E' . info['error'])
  endif
  if get(info, 'warning', 0)
    call add(msgs, 'W' . info['warning'])
  endif
  return join(msgs, ' ') . ' ' . get(g:, 'coc_status', '')
endfunction

" Add (Neo)Vim's native statusline support.
" NOTE: Please see `:h coc-status` for integrations with external plugins that
" provide custom statusline: lightline.vim, vim-airline.
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}%{StatusDiagnostic()}

" Show all diagnostics (errors).
nnoremap <silent> <space>e  :<C-u>CocList diagnostics<cr>  

" Nerdtree
let g:NERDTreeShowHidden = 1
let g:NERDTreeMinimalUI = 1
let g:NERDTreeIgnore = []
let g:NERDTreeStatusline = ''
let g:NERDTreeIgnore = ['\.git.*$[[dir]]']
" Automaticaly close nvim if NERDTree is only thing left open
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
" Toggle
nnoremap <silent> <C-b> :NERDTreeToggle<CR>
" Nerdtree highlight
let g:NERDTreeFileExtensionHighlightFullName = 1
let g:NERDTreeExactMatchHighlightFullName = 1
let g:NERDTreePatternMatchHighlightFullName = 1
let g:NERDTreeHighlightFolders = 1 " enables folder icon highlighting using exact match
let g:NERDTreeHighlightFoldersFullName = 1 " highlights the folder name
