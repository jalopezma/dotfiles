return {
  'nvim-telescope/telescope.nvim',
  --tag = '0.1.x',
  dependencies = {
    'nvim-lua/plenary.nvim',
    {
      'nvim-telescope/telescope-fzf-native.nvim',
      build = 'make',
      -- enabled = false,
    },
  },
  keys = {
    { '<leader>ff', '<cmd>Telescope find_files<cr>', desc = 'Find files' },
    { '<leader>fg', '<cmd>Telescope live_grep<cr>', desc = 'Search string' },
    { '<leader>fw', '<cmd>Telescope grep_string<cr>', desc = 'Search word under cursor' },
    { '<leader>fb', '<cmd>Telescope buffers<cr>', desc = 'Find buffers' },
  },
  -- enabled = false,
  config = function()
    local actions = require('telescope.actions')
    require('telescope').setup({
      defaults = {
        mappings = {
          i = {
            ['<esc>'] = actions.close,
            ['<C-s>'] = actions.select_horizontal,
          },
        },
      },
    })

    -- load fzf native
    require('telescope').load_extension('fzf')
  end,
}
