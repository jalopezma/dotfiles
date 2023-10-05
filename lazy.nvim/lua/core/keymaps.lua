-- Keymaps
-- Plugin keymaps are kept under each plugin
-- In which-key we are labeling groups
local map = vim.keymap.set

vim.g.mapleader = ' '
vim.g.maplocalleader = '\\'

-- Open lazy.vim config
map('n', '<leader>v', '<cmd>tabnew ~/.config/nvim/<cr>', { desc = 'Open ~/.config/nvim' })

map({ 'i' }, 'jk', '<esc>', { desc = 'Go normal mode' })

-- better up/down to navigate through a line displayed in multiple lines
map({ 'n', 'x' }, 'j', 'v:count == 0 ? "gj" : "j"', { expr = true, silent = true })
map({ 'n', 'x' }, 'k', 'v:count == 0 ? "gk" : "k"', { expr = true, silent = true })

-- Move to window using the <ctrl> hjkl keys
map('n', '<C-h>', '<C-w>h', { desc = 'Go to left window', remap = true })
map('n', '<C-j>', '<C-w>j', { desc = 'Go to lower window', remap = true })
map('n', '<C-k>', '<C-w>k', { desc = 'Go to upper window', remap = true })
map('n', '<C-l>', '<C-w>l', { desc = 'Go to right window', remap = true })

-- Clear search with <backspace> in normal
map('n', '<backspace>', '<cmd>noh<cr>', { desc = 'Escape and clear hlsearch' })

-- https://github.com/mhinz/vim-galore#saner-behavior-of-n-and-n
map('n', 'n', '"Nn"[v:searchforward]', { expr = true, desc = 'Next search result' })
map('x', 'n', '"Nn"[v:searchforward]', { expr = true, desc = 'Next search result' })
map('o', 'n', '"Nn"[v:searchforward]', { expr = true, desc = 'Next search result' })
map('n', 'N', '"nN"[v:searchforward]', { expr = true, desc = 'Prev search result' })
map('x', 'N', '"nN"[v:searchforward]', { expr = true, desc = 'Prev search result' })
map('o', 'N', '"nN"[v:searchforward]', { expr = true, desc = 'Prev search result' })

-- Add undo break-points
map('i', ',', ',<c-g>u')
map('i', '.', '.<c-g>u')
map('i', ';', ';<c-g>u')

-- save file
map({ 'i', 'x', 'n', 's' }, '<C-s>', '<cmd>w<cr><esc>', { desc = 'Save file' })

--keywordprg
map('n', '<leader>K', '<cmd>norm! K<cr>', { desc = 'Keywordprg' })

-- better indenting
map('v', '<', '<gv')
map('v', '>', '>gv')

-- quit
map('n', '<leader>qq', '<cmd>qa<cr>', { desc = 'Quit all' })

-- windows
map('n', '<leader>ww', '<C-W>p', { desc = 'Other window', remap = true })
map('n', '<leader>wd', '<C-W>c', { desc = 'Delete window', remap = true })
map('n', '<leader>w-', '<C-W>s', { desc = 'Split window below', remap = true })
map('n', '<leader>w|', '<C-W>v', { desc = 'Split window right', remap = true })

-- buffers
-- Prevent to close the window when closing the last buffer changing to the last buffer and deleting the previous one
map('n', '<leader>bd', '<cmd>bp | bd #<cr>', { desc = 'Delete buffer' })
map('n', '<leader>bp', '<cmd>bprevious<cr>', { desc = 'Previous buffer' })
map('n', '<leader>bn', '<cmd>bnext<cr>', { desc = 'Next buffer' })
map('n', '<leader>bl', '<cmd>b#<cr>', { desc = 'Last buffer' })

-----------------------------------------------------------------------------------
-- To rethink if I wan t to keep them                                            --
-----------------------------------------------------------------------------------
-- lazy
-- map('n', '<leader>l', '<cmd>Lazy<cr>', { desc = 'Lazy' })

-- new file
-- map('n', '<leader>fn', '<cmd>enew<cr>', { desc = 'New File' })

-- tabs
-- map('n', '<leader><tab><tab>', '<cmd>tabnew<cr>', { desc = 'New Tab' })
-- map('n', '<leader><tab>d', '<cmd>tabclose<cr>', { desc = 'Close Tab' })
-- map('n', '<leader><tab>h', '<cmd>tabprevious<cr>', { desc = 'Previous Tab' })
-- map('n', '<leader><tab>l', '<cmd>tabnext<cr>', { desc = 'Next Tab' })

-- map('n', '<leader>xl', '<cmd>lopen<cr>', { desc = 'Location List' })
-- map('n', '<leader>xq', '<cmd>copen<cr>', { desc = 'Quickfix List' })

-- Clear search, diff update and redraw
-- taken from runtime/lua/_editor.lua
-- map('n', '<leader>ur', '<Cmd>nohlsearch<Bar>diffupdate<Bar>normal! <C-L><CR>', { desc = 'Redraw / clear hlsearch / diff update' })

-- Terminal Mappings
-- map('t', '<esc>', '<c-\\><c-n>', { desc = 'Enter Normal Mode' })
-- map('t', 'jk', '<c-\\><c-n>', { desc = 'Enter Normal Mode' })
-- map('t', '<C-h>', '<cmd>wincmd h<cr>', { desc = 'Go to left window' })
-- map('t', '<C-j>', '<cmd>wincmd j<cr>', { desc = 'Go to lower window' })
-- map('t', '<C-k>', '<cmd>wincmd k<cr>', { desc = 'Go to upper window' })
-- map('t', '<C-l>', '<cmd>wincmd l<cr>', { desc = 'Go to right window' })
-- map('t', '<C-/>', '<cmd>close<cr>', { desc = 'Hide Terminal' })
-- map('t', '<c-_>', '<cmd>close<cr>', { desc = 'which_key_ignore' })
