return {
  'nvim-telescope/telescope.nvim',
  --tag = '0.1.x',
  dependencies = {
    'nvim-lua/plenary.nvim',
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

    local builtin = require('telescope.builtin')
    vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = 'Find files' })
    vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = 'Search string' })
    vim.keymap.set('n', '<leader>fw', builtin.grep_string, { desc = 'Search word under cursor' })
    vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = 'Find buffers' })
  end,
}
