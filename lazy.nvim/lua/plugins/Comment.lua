return {
  'numToStr/Comment.nvim',
  config = function()
    require('Comment').setup({
      sticky = true,
      --- Disable keymaps, I'll add them manually
      mappings = false,
      --- Function to call before (un)comment
      pre_hook = require('ts_context_commentstring.integrations.comment_nvim').create_pre_hook(),
    })

    -- Toggle current line or with count
    vim.keymap.set('n', 'gc', function()
        return vim.v.count == 0
            and '<Plug>(comment_toggle_linewise_current)'
            or '<Plug>(comment_toggle_linewise_count)'
    end, { expr = true, desc = 'Comment current line' })

    vim.keymap.set('n', 'gb', function()
        return vim.v.count == 0
            and '<Plug>(comment_toggle_blockwise_current)'
            or '<Plug>(comment_toggle_blockwise_count)'
    end, { expr = true, desc = 'Comment current block' })


    -- Toggle in VISUAL mode
    vim.keymap.set('x', 'gc', '<Plug>(comment_toggle_linewise_visual)', { desc = 'Comment line visual' })
    vim.keymap.set('x', 'gb', '<Plug>(comment_toggle_blockwise_visual)', { desc = 'Comment block line visual' })
  end,
  -- enabled = false,
  dependencies = {
    --- Used to comment tsx properly
    'JoosepAlviste/nvim-ts-context-commentstring',
  },
}

