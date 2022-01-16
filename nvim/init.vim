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
Plug 'nvim-lualine/lualine.nvim'
" To have icons in your statusline choose one of these
Plug 'kyazdani42/nvim-web-devicons'

" Moving shortcuts/motions: <Leader><Leader>s{char} -> {target-chars}
Plug 'easymotion/vim-easymotion'

" Icons
Plug 'ryanoasis/vim-devicons'

" A fuzzy finder over lists
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'

" whitespaces
Plug 'ntpeters/vim-better-whitespace'

" Nearley JS parser syntax
Plug 'tjvr/vim-nearley'

" Improving highlighting syntax - Requires nvim nightly 5.0
" You need to run :TSInstall all
" We recommend updating the parsers on update
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}

" Rainbow parenthesis
Plug 'p00f/nvim-ts-rainbow'
Plug 'jiangmiao/auto-pairs'

" VCL Fastly
Plug 'fgsch/vim-varnish'

call plug#end()

let g:mapleader = "\<Space>"
" Opens init.vim
nnoremap <leader>v :tabnew ~/.config/nvim/init.vim<CR>
" Sources init.vim
nnoremap <leader>s :source ~/.config/nvim/init.vim<CR>
" Source Vim configuration file and install plugins
nnoremap <silent><leader>1 :source ~/.config/nvim/init.vim \| :PlugInstall<CR>

" --- COLORS SCHEMA ---
if (has('termguicolors'))
  set termguicolors
endif
syntax enable

colorscheme material
" colorscheme base16-onedark
" Options: 'default' | 'palenight' | 'ocean' | 'lighter' | 'darker'
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
" set cc=100                \ set an 100 column border for good coding style
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
" mkdir -p ~/.config/nvim/{backup_files,swap_files,undo_files}
set backupdir=~/.config/nvim/backup_files//
set directory=~/.config/nvim/swap_files//
set undodir=~/.config/nvim/undo_files//

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

" Neovim terminal remap escape to go normal mode
:tnoremap <Esc> <C-\><C-n>
:tnoremap jk <C-\><C-n>

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
" --- Python ---
let g:python3_host_prog = '/usr/bin/python3'

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

" --- neoclide/coc.nvim ---
" Typescript autocompletition
" npm install -g typescript-language-server

let g:coc_node_path = '~/.nvm/versions/node/v16.13.1/bin/node'
" Set extensions
let g:coc_global_extensions = ['coc-css', 'coc-html', 'coc-json', 'coc-tsserver', 'coc-git', 'coc-yank', 'coc-pairs', 'coc-highlight', 'coc-eslint', 'coc-actions', 'coc-java', 'coc-explorer', 'coc-fzf-preview', 'coc-metals', 'coc-pyright', 'coc-go', 'coc-sh']
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
:nmap <C-n> :CocCommand explorer --width=50<CR>
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

" --- ntpeters/vim-better-whitespace ---
let g:better_whitespace_enabled=1
let g:strip_whitespace_on_save=1
let g:strip_max_file_size = 1000
let g:show_spaces_that_precede_tabs=1

" --- Telescope
" Find files using Telescope command-line sugar.
nnoremap <leader>f <cmd>Telescope git_files<cr>
" When is not a git folder. It could be fixed by this [https://github.com/nvim-telescope/telescope.nvim/wiki/Configuration-Recipes#falling-back-to-find_files-if-git_files-cant-find-a-git-directory]
" but couldn't make it work
nnoremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <leader>g <cmd>Telescope live_grep<cr>
nnoremap <leader>j <cmd>Telescope grep_string<cr>
lua <<EOF
local actions = require("telescope.actions")
require("telescope").setup{
  defaults = {
    mappings = {
      i = {
        ["<esc>"] = actions.close
      },
    },
  }
}
EOF

" --- nvim treesiter
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

" --- Lualine - status bar configuration
lua << END
require('lualine').setup {
  options = {
    icons_enabled = true,
    theme = 'material',
    component_separators = { left = '', right = ''},
    section_separators = { left = '', right = ''},
    disabled_filetypes = {},
    always_divide_middle = true,
  },
  sections = {
    lualine_a = {'mode'},
    lualine_b = {'branch', 'diff', 'diagnostics'},
    lualine_c = {'filename'},
    lualine_x = {'encoding', 'fileformat', 'filetype'},
    lualine_y = {'progress'},
    lualine_z = {'location'}
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = {'filename'},
    lualine_x = {'location'},
    lualine_y = {},
    lualine_z = {}
  },
  tabline = {},
  extensions = {}
}
END
