return {
  'nvim-telescope/telescope.nvim',
  --tag = '0.1.x',
  dependencies = { 'nvim-lua/plenary.nvim' },
  config = function()
    local actions = require('telescope.actions')
    require('telescope').setup({
      defaults = {
        mappings = {
          i = { ['<esc>'] = actions.close, },
        },
      },
    })

    -- load fzf native
    require('telescope').load_extension('fzf')

    local builtin = require('telescope.builtin')
    vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
    vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
    vim.keymap.set('n', '<leader>fj', builtin.grep_string, {})
    vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
  end,
}

