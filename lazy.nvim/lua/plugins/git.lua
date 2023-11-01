return {
  {
    'lewis6991/gitsigns.nvim',
    opts = {
      signs = {
        add = { text = '▎' },
        change = { text = '▎' },
        delete = { text = '' },
        topdelete = { text = '' },
        changedelete = { text = '▎' },
        untracked = { text = '▎' },
      },
      on_attach = function(buffer)
        local gs = package.loaded.gitsigns
        local function map(mode, l, r, desc)
          vim.keymap.set(mode, l, r, { buffer = buffer, desc = desc })
        end

        map('n', '<leader>gb', function() gs.blame_line({ full = true }) end, 'Blame Line')
      end,
    },
    -- enabled = false,
  },

  {
    'tpope/vim-fugitive',
    -- Load plugin when any of the the following commands are executed
    cmd = {
      'Git',
      'Gvdiffsplit',
      'Gread'
    },
    -- enabled = false,
  },
}
