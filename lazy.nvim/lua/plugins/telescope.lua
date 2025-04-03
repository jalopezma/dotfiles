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
    { '<leader>ff', '<cmd>Telescope find_files<cr>',  desc = 'Find files' },
    { '<leader>fg', '<cmd>Telescope live_grep<cr>',   desc = 'Search string' },
    { '<leader>fw', '<cmd>Telescope grep_string<cr>', desc = 'Search word under cursor' },
    { '<leader>fb', '<cmd>Telescope buffers<cr>',     desc = 'Find buffers' },
  },
  -- enabled = false,
  config = function()
    local telescope = require('telescope')
    local telescopeConfig = require('telescope.config')
    local actions = require('telescope.actions')

    -- Clone the default Telescope configuration
    local vimgrep_arguments = { unpack(telescopeConfig.values.vimgrep_arguments) }

    -- I want to search in hidden/dot files.
    table.insert(vimgrep_arguments, '--hidden')
    -- I don't want to search in the `.git` directory.
    table.insert(vimgrep_arguments, '--glob')
    table.insert(vimgrep_arguments, '!**/.git/*')

    telescope.setup({
      defaults = {
        -- `hidden = true` is not supported in text grep commands.
        vimgrep_arguments = vimgrep_arguments,
        mappings = {
          i = {
            ['<esc>'] = actions.close,
            ['<C-s>'] = actions.select_horizontal,
          },
        },
      },
      pickers = {
        find_files = {
          -- `hidden = true` will still show the inside of `.git/` as it's not `.gitignore`d.
          find_command = { 'rg', '--files', '--hidden', '--glob', '!**/.git/*' },
        },
      },
    })

    -- load fzf native
    require('telescope').load_extension('fzf')
  end,
}
