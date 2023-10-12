return {
  'numToStr/Comment.nvim',
  -- Lazy load when keymappings are enabled
  -- Also only enables the mapping defined here
  keys = {
    -- Toggle current line or with count
    {
      'gc',
      function()
        return vim.v.count == 0
            and '<Plug>(comment_toggle_linewise_current)'
            or '<Plug>(comment_toggle_linewise_count)'
      end,
      expr = true,
      desc = 'Comment current line',
    },

    -- Toggle current block
    {
      'gb',
      function()
          return vim.v.count == 0
              and '<Plug>(comment_toggle_blockwise_current)'
              or '<Plug>(comment_toggle_blockwise_count)'
      end,
      expr = true,
      desc = 'Comment current block',
    },

    -- Toggle line in VISUAL mode
    { 'gc', '<Plug>(comment_toggle_linewise_visual)', mode = 'x', desc = 'Comment line visual' },
    -- Toggle block in VISUAL mode
    { 'gb', '<Plug>(comment_toggle_blockwise_visual)', mode = 'x', desc = 'Comment block line visual' },
  },
  config = function()
    require('Comment').setup({
      sticky = true,
      --- Disable keymaps, I'll add them manually
      mappings = false,
      --- Function to call before (un)comment
      pre_hook = require('ts_context_commentstring.integrations.comment_nvim').create_pre_hook(),
    })
  end,
  -- enabled = false,
  dependencies = {
    --- Used to comment tsx properly
    'JoosepAlviste/nvim-ts-context-commentstring',
  },
}

