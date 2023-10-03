return {
  'nvim-neo-tree/neo-tree.nvim',
  branch = 'v3.x',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-tree/nvim-web-devicons', -- not strictly required, but recommended
    'MunifTanjim/nui.nvim',
  },
  -- enabled = false,
  config = function()
    -- If you want icons for diagnostic errors, you'll need to define them somewhere:
    vim.fn.sign_define('DiagnosticSignError',
      { text = ' ', texthl = 'DiagnosticSignError' })
    vim.fn.sign_define('DiagnosticSignWarn',
      { text = ' ', texthl = 'DiagnosticSignWarn' })
    vim.fn.sign_define('DiagnosticSignInfo',
      { text = ' ', texthl = 'DiagnosticSignInfo' })
    vim.fn.sign_define('DiagnosticSignHint',
      { text = '󰌵', texthl = 'DiagnosticSignHint' })

    require('neo-tree').setup({
      window = {
        width = 50,
        mappings = {
          ['<space>'] = {
            'toggle_node',
            nowait = false, -- disable `nowait` if you have existing combos starting with this char that you want to use
          },
          ['<cr>'] = 'open',
          ['<esc>'] = 'cancel', -- close preview or floating neo-tree window
          ['P'] = { 'toggle_preview', config = { use_float = true } },
          ['l'] = 'focus_preview',
          ['S'] = 'open_split',
          ['s'] = 'open_vsplit',
          ['t'] = 'open_tabnew',
          ['C'] = 'close_node',
          ['z'] = 'close_all_nodes',
          ['Z'] = 'expand_all_nodes',
          ['r'] = 'rename',
          ['y'] = 'copy_to_clipboard',
          ['q'] = 'close_window',
          ['R'] = 'refresh',
          ['?'] = 'show_help',
          ['<'] = 'prev_source',
          ['>'] = 'next_source',
        }
      },
      filesystem = {
        filtered_items = {
          hide_dotfiles = true,
          hide_gitignored = true,
          hide_hidden = true, -- only works on Windows for hidden files/directories
          hide_by_name = {
            --'node_modules'
          },
          hide_by_pattern = { -- uses glob style patterns
            --'*.meta',
            --'*/src/*/tsconfig.json',
          },
          always_show = { -- remains visible even if other settings would normally hide it
            --'.gitignored',
          },
          never_show = { -- remains hidden even if visible is toggled to true, this overrides always_show
            --'.DS_Store',
            --'thumbs.db'
          },
          never_show_by_pattern = { -- uses glob style patterns
            --'.null-ls_*',
          },
        },
        window = {
          mappings = {
            ['<bs>'] = 'navigate_up',
            ['.'] = 'set_root',
            ['H'] = 'toggle_hidden',
            ['/'] = 'fuzzy_finder',
            ['f'] = 'filter_on_submit',
            ['<c-x>'] = 'clear_filter',
            ['o'] = { 'show_help', nowait = false, config = { title = 'Order by', prefix_key = 'o' } },
          },
        },
      },
      buffers = {
        show_unloaded = true,
        window = {
          mappings = {
            ['bd'] = 'buffer_delete',
            ['<bs>'] = 'navigate_up',
            ['.'] = 'set_root',
            ['o'] = { 'show_help', nowait = false, config = { title = 'Order by', prefix_key = 'o' } },
          }
        },
      },
    })

    vim.keymap.set('n', '<leader>e', '<cmd>Neotree toggle<cr>', { desc = 'Toggle Neo-tree explorer' })
  end,
}
