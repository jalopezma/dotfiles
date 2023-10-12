return {
  'smoka7/hop.nvim',
  version = '*',
  opts = {},
  -- enabled = false,
  keys = {
    { '<leader>sw', '<cmd>HopWord<cr>', desc = 'Hop to word' },
    { '<leader>sc', '<cmd>HopChar1<cr>', desc = 'Hop to a char' },
  },
  -- config = function()
  --   local hop = require('hop').setup()

    -- local directions = require('hop.hint').HintDirection
    -- Disabled for now as it doesn't work with ; and I might not want to have this anymore
    -- extends f/F/t/T search adding the motion if more than one ocurrence
    --[[ vim.keymap.set('', 'f', function()
      hop.hint_char1({ direction = directions.AFTER_CURSOR, current_line_only = true })
    end, { remap = true })

    vim.keymap.set('', 'F', function()
      hop.hint_char1({ direction = directions.BEFORE_CURSOR, current_line_only = true })
   end, { remap = true })

    vim.keymap.set('', 't', function()
      hop.hint_char1({ direction = directions.AFTER_CURSOR, current_line_only = true, hint_offset = -1 })
    end, { remap = true })

    vim.keymap.set('', 'T', function()
      hop.hint_char1({ direction = directions.BEFORE_CURSOR, current_line_only = true, hint_offset = 1 })
    end, { remap = true }) ]]
  -- end,
}
