" VimPlug
call plug#begin()
" Colorscheme
Plug 'kaicataldo/material.vim'

" Full LanguageServerProtocol
Plug 'neoclide/coc.nvim', {'branch': 'release'}
" TS TSX and JSX suuport
Plug 'leafgarland/typescript-vim'
Plug 'peitalin/vim-jsx-typescript'
" Git
Plug 'tpope/vim-fugitive'
" To be able to run :GBrowse and open the file in git
Plug 'tpope/vim-rhubarb'
" Git, add column with status if line has been changed
Plug 'mhinz/vim-signify'
" Status bar
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
" Moving shortcuts/motions: <Leader><Leader>s{char} -> {target-chars}
Plug 'easymotion/vim-easymotion'
" Icons
Plug 'ryanoasis/vim-devicons'
" Fzf and search
Plug 'Shougo/denite.nvim'
" whitespaces
Plug 'ntpeters/vim-better-whitespace'
Plug 'jiangmiao/auto-pairs'

" Nearley JS parser syntax
Plug 'tjvr/vim-nearley'

" Improving highlighting syntax - Requires nvim nightly 5.0
" You need to run :TSInstall all
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}  " We recommend updating the parsers on update

" Rainbow parenthesis
Plug 'p00f/nvim-ts-rainbow'

" fzf and fzf-preview. Also used to do gdiff with delta
" Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
" Plug 'yuki-ycino/fzf-preview.vim', { 'branch': 'release', 'do': ':UpdateRemotePlugins' }
call plug#end()

let g:mapleader = "\<Space>"
" Opens init.vim
nnoremap <leader>v :tabnew ~/.config/nvim/init.vim<CR>
" Sources init.vim
nnoremap <leader>s :source ~/.config/nvim/init.vim<CR>

" --- COLORS SCHEMA ---
if (has('termguicolors'))
  set termguicolors
endif
syntax enable

" colorscheme material
colorscheme base16-onedark
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
" set cc=100                  " set an 100 column border for good coding style
filetype plugin indent on   " allows auto-indenting depending on file type
syntax on                   " syntax highlighting
set tabstop=2               " size of an 'indent'
set shiftwidth=2            " a combination of spaces and tabas are used to simulate tab stops at a width other than the (hard)tabstop
set softtabstop=2
set smarttab                " make 'tab' insert indents instead of tabs at the beinning fo a line
set expandtab               " always uses spaces instead of tab characters
set undofile                " Creates <FILENAME>.un~ so you can undo actions done even when you exit vim
set winbl=10                " Set floating window to be slightly transparent

" set dir for swap, backup and undo files. Do before:
" mkdir -p ~/.vim/{backup_files,swap_files,undo_files}
set backupdir=~/.vim/backup_files//
set directory=~/.vim/swap_files//
set undodir=~/.vim/undo_files//

" Add icon to breakline
set showbreak=↪

" Enable spellcheck for markdown files
autocmd BufRead,BufNewFile *.md setlocal spell

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

" For Scala (only?) if hidden is not set, TextEdit might fail.
set hidden
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

" :FormatJSON to use it. Requires python installed
com! FormatJSON %!python -m json.tool

" Sets the + (unnamedplus) and * (unnamed) registers to be used as ctrl+v/c
set clipboard^=unnamedplus

" --- Scala ----
" Help Vim recognize *.sbt and *.sc as Scala files
au BufRead,BufNewFile *.sbt,*.sc set filetype=scala

" Trigger for code actions
" Make sure `"codeLens.enable": true` is set in your coc config
nnoremap <leader>cl :<C-u>call CocActionAsync('codeLensAction')<CR>

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
let g:coc_global_extensions = ['coc-css', 'coc-html', 'coc-json', 'coc-tsserver', 'coc-python', 'coc-git', 'coc-yank', 'coc-pairs', 'coc-highlight', 'coc-eslint', 'coc-actions', 'coc-java', 'coc-explorer', 'coc-fzf-preview', 'coc-metals']
" coc.nvim uses jsonc as a configuration file format. It's basically json with comment support.
" In order to get comment highlighting:
autocmd FileType json syntax match Comment +\/\/.\+$+

" --- coc.nvim extensions ---
" coc-yank - :CocCommand yank.clean - to clean
nnoremap <silent> <leader>y  :<C-u>CocList -A --normal yank<cr>

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

"Close preview window when completion is done.
autocmd! CompleteDone * if pumvisible() == 0 | pclose | endif

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
" nmap <silent> <leader>p <Plug>(coc-diagnostic-prev)
nmap <silent> <leader>n <Plug>(coc-diagnostic-next)

" Remap keys for applying codeAction to the current line.
nmap <leader>ac  <Plug>(coc-codeaction)

" Apply AutoFix to problem on the current line.
nmap <leader>q  <Plug>(coc-fix-current)

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)
nmap <leader>rf <Plug>(coc-rename)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap gds :vsplit<ENTER><C-w><Right><Plug>(coc-definition)
nmap gD :tabnew %<ENTER><C-w><Right><Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" coc-explorer
:nmap <C-n> :CocCommand explorer<CR>
autocmd BufEnter * if (winnr("$") == 1 && &filetype == 'coc-explorer') | q | endif

" Set Prettier command to be able to do :Prettier
command! -nargs=0 Prettier :call CocAction('runCommand', 'prettier.formatFile')
" Run :Prettier on leave insert mode. On save is done by CocSettings
" autocmd InsertLeave *.ts,*.tsx Prettier

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>
function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Show all diagnostics (errors).
nnoremap <silent> <leader>e  :<C-u>CocList diagnostics<cr>

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

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

" coc-actions: Remap for do codeAction of selected region
function! s:cocActionsOpenFromSelected(type) abort
  execute 'CocCommand actions.open ' . a:type
endfunction
xmap <silent> <leader>a :<C-u>execute 'CocCommand actions.open ' . visualmode()<CR>
nmap <silent> <leader>a :<C-u>set operatorfunc=<SID>cocActionsOpenFromSelected<CR>g@
" <leader>a for the current selected range
" <leader>aw for the current word
" <leader>aas for the current sentence
" <leader>aap for the current paragraph
" :h text-objects to see more detail

" --- peitalin/vim-jsx-typescript ---
" set filetypes as typescript.tsx
autocmd BufNewFile,BufRead *.tsx,*.jsx set filetype=typescript.tsx

" --- vim-airline/vim-airline ---
" Add (Neo)Vim's native statusline support.
" NOTE: Please see `:h coc-status` for integrations with external plugins that
" provide custom statusline: lightline.vim, vim-airline.
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}%{StatusDiagnostic()}
" Custom setup that removes filetype/whitespace from default vim airline bar
" -> remove c?
let g:airline#extensions#default#layout = [['a', 'b', 'c'], ['x', 'z', 'warning', 'error']]
" let g:airline_extensions = ['branch', 'hunks', 'coc']

" --- ntpeters/vim-better-whitespace ---
let g:better_whitespace_enabled=1
let g:strip_whitespace_on_save=1
let g:strip_max_file_size = 1000
let g:show_spaces_that_precede_tabs=1

" --- Denite ---
" Disable statusline for denite
call denite#custom#option('_', 'statusline', v:false)

"  Does need ripgrep https://github.com/BurntSushi/ripgrep#installation
" Use ripgrep for searching current directory for files
" By default, ripgrep will respect rules in .gitignore
"   --files: Print each file that would be searched (but don't search)
"   --glob:  Include or exclues files for searching that match the given glob
"            (aka ignore .git files)
"
call denite#custom#var('file/rec', 'command', ['rg', '--files', '--glob', '!.git'])

" Use ripgrep in place of "grep"
call denite#custom#var('grep', 'command', ['rg'])

" Custom options for ripgrep
"   --vimgrep:  Show results with every match on it's own line
"   --hidden:   Search hidden directories and files
"   --heading:  Show the file name above clusters of matches from each file
"   --S:        Search case insensitively if the pattern is all lowercase
call denite#custom#var('grep', 'default_opts', ['--hidden', '--vimgrep', '--heading', '-S'])

" Recommended defaults for ripgrep via Denite docs
call denite#custom#var('grep', 'recursive_opts', [])
call denite#custom#var('grep', 'pattern_opt', ['--regexp'])
call denite#custom#var('grep', 'separator', ['--'])
call denite#custom#var('grep', 'final_opts', [])

" Remove date from buffer list
call denite#custom#var('buffer', 'date_format', '')

" Custom options for Denite
"   auto_resize             - Auto resize the Denite window height automatically.
"   prompt                  - Customize denite prompt
"   direction               - Specify Denite window direction as directly below current pane
"   winminheight            - Specify min height for Denite window
"   highlight_mode_insert   - Specify h1-CursorLine in insert mode
"   prompt_highlight        - Specify color of prompt
"   highlight_matched_char  - Matched characters highlight
"   highlight_matched_range - matched range highlight
let s:denite_options = {'default' : {
\ 'auto_resize': 1,
\ 'prompt': 'λ ',
\ 'split': 'horizontal',
\ 'start_filter': 1,
\ 'source_names': 'short',
\ 'highlight_mode_insert': 'Visual',
\ 'highlight_mode_normal': 'Visual',
\ 'highlight_matched_char': 'Function',
\ 'highlight_matched_range': 'Normal',
\ 'prompt_highlight': 'Function',
\ 'highlight_window_background': 'Visual',
\ 'highlight_filter_background': 'DiffAdd',
\ 'winrow': 1,
\ 'winminheight': '10',
\ 'vertical_preview': 1,
\ }}

" Loop through denite options and enable them
function! s:profile(opts) abort
  for l:fname in keys(a:opts)
    for l:dopt in keys(a:opts[l:fname])
      call denite#custom#option(l:fname, l:dopt, a:opts[l:fname][l:dopt])
    endfor
  endfor
endfunction

call s:profile(s:denite_options)
" === Denite shorcuts === "
"   ;         - Browser currently open buffers
"   <leader>t - Browse list of files in current directory
"   <leader>g - Search current directory for occurences of given term and close window if no results
"   <leader>j - Search current directory for occurences of word under cursor
nmap <leader>w :Denite buffer<CR>
nmap <leader>f :DeniteProjectDir file/rec<CR>
nnoremap <leader>g :<C-u>Denite grep:. -no-empty<CR>
nnoremap <leader>j :<C-u>DeniteCursorWord grep:.<CR>

" Define mappings while in 'filter' mode
"   <C-o>         - Switch to normal mode inside of search results
"   <Esc>         - Exit denite window in any mode
"   <CR>          - Open currently selected file in any mode
"   <C-t>         - Open currently selected file in a new tab
"   <C-v>         - Open currently selected file a vertical split
"   <C-h>         - Open currently selected file in a horizontal split
autocmd FileType denite-filter call s:denite_filter_my_settings()
function! s:denite_filter_my_settings() abort
  imap <silent><buffer> <Tab>
  \ <Plug>(denite_filter_update)
  inoremap <silent><buffer><expr> <Esc>
  \ denite#do_map('quit')
  nnoremap <silent><buffer><expr> <Esc>
  \ denite#do_map('quit')
  inoremap <silent><buffer><expr> <CR>
  \ denite#do_map('do_action')
  inoremap <silent><buffer><expr> <C-t>
  \ denite#do_map('do_action', 'tabopen')
  inoremap <silent><buffer><expr> <C-v>
  \ denite#do_map('do_action', 'vsplit')
  inoremap <silent><buffer><expr> <C-h>
  \ denite#do_map('do_action', 'split')
endfunction

" Define mappings while in denite window
"   <CR>        - Opens currently selected file
"   q or <Esc>  - Quit Denite window
"   d           - Delete currenly selected file
"   p           - Preview currently selected file
"   <C-o> or i  - Switch to insert mode inside of filter prompt
"   <C-t>       - Open currently selected file in a new tab
"   <C-v>       - Open currently selected file a vertical split
"   <C-h>       - Open currently selected file in a horizontal split
autocmd FileType denite call s:denite_my_settings()
function! s:denite_my_settings() abort
  nnoremap <silent><buffer><expr> <CR>
  \ denite#do_map('do_action')
  nnoremap <silent><buffer><expr> q
  \ denite#do_map('quit')
  nnoremap <silent><buffer><expr> <Esc>
  \ denite#do_map('quit')
  nnoremap <silent><buffer><expr> d
  \ denite#do_map('do_action', 'delete')
  nnoremap <silent><buffer><expr> p
  \ denite#do_map('do_action', 'preview')
  nnoremap <silent><buffer><expr> i
  \ denite#do_map('open_filter_buffer')
  nnoremap <silent><buffer><expr> <Tab>
  \ denite#do_map('open_filter_buffer')
  nnoremap <silent><buffer><expr> <C-t>
  \ denite#do_map('do_action', 'tabopen')
  nnoremap <silent><buffer><expr> <C-v>
  \ denite#do_map('do_action', 'vsplit')
  nnoremap <silent><buffer><expr> <C-h>
  \ denite#do_map('do_action', 'split')
endfunction

" Custom styles
" Add custom highlights in method that is executed every time a colorscheme is sourced
" See https://gist.github.com/romainl/379904f91fa40533175dfaec4c833f2f for details
function! TrailingSpaceHighlights() abort
  " Hightlight trailing whitespace
  highlight Trail ctermbg=red guibg=red
  call matchadd('Trail', '\s\+$', 100)
endfunction

function! s:custom_jarvis_colors()
  " coc.nvim color changes
  hi link CocErrorSign WarningMsg
  hi link CocWarningSign Number
  hi link CocInfoSign Type

  " Make background transparent for many things
  hi Normal ctermbg=NONE guibg=NONE
  hi NonText ctermbg=NONE guibg=NONE
  hi LineNr ctermfg=NONE guibg=NONE
  hi SignColumn ctermfg=NONE guibg=NONE
  hi StatusLine guifg=#16252b guibg=#6699CC
  hi StatusLineNC guifg=#16252b guibg=#16252b

  " Try to hide vertical spit and end of buffer symbol
  hi VertSplit gui=NONE guifg=#17252c guibg=#17252c
  hi EndOfBuffer ctermbg=NONE ctermfg=NONE guibg=#17252c guifg=#17252c

  " Make background color transparent for git changes
  hi SignifySignAdd guibg=NONE
  hi SignifySignDelete guibg=NONE
  hi SignifySignChange guibg=NONE

  " Highlight git change signs
  hi SignifySignAdd guifg=#99c794
  hi SignifySignDelete guifg=#ec5f67
  hi SignifySignChange guifg=#c594c5
endfunction

autocmd! ColorScheme * call TrailingSpaceHighlights()
autocmd! ColorScheme material call s:custom_jarvis_colors()

" Call method on window enter
augroup WindowManagement
  autocmd!
  autocmd WinEnter * call Handle_Win_Enter()
augroup END

" Change highlight group of preview window when open
function! Handle_Win_Enter()
  if &previewwindow
    setlocal winhighlight=Normal:MarkdownError
  endif
endfunction

" https://github.com/nvim-treesitter/nvim-treesitter
" Configuration to enable modules
" - highlighting
"  rainbow = {
"    enable = true
"  },
"  highlight = {
"    enable = true,
"    custom_captures = {
"      -- Highlight the @foo.bar capture group with the "Identifier" highlight group.
"      ["foo.bar"] = "Identifier",
"    },
"  },


lua <<EOF
require'nvim-treesitter.configs'.setup {
  highlight = {
    enable = true,
  }
}

EOF
