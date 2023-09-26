return {
  'smoka7/hop.nvim',
  version = '*',
  opts = {},
  -- enabled = false,
  config = function()
    local hop = require('hop')
    hop.setup()
    local directions = require('hop.hint').HintDirection

    -- extends f/F/t/T search adding the motion if more than one ocurrence
    vim.keymap.set('', 'f', function()
      hop.hint_char1({ direction = directions.AFTER_CURSOR, current_line_only = true })
    end, {remap=true})

    vim.keymap.set('', 'F', function()
      hop.hint_char1({ direction = directions.BEFORE_CURSOR, current_line_only = true })
    end, {remap=true})

    vim.keymap.set('', 't', function()
      hop.hint_char1({ direction = directions.AFTER_CURSOR, current_line_only = true, hint_offset = -1 })
    end, {remap=true})

    vim.keymap.set('', 'T', function()
      hop.hint_char1({ direction = directions.BEFORE_CURSOR, current_line_only = true, hint_offset = 1 })
    end, {remap=true})

    local map = vim.keymap.set
    map("n", "<leader>mw", "<cmd>HopWord<cr>", { desc = "Hop to word" })
    map("n", "<leader>mc", "<cmd>HopChar1<cr>", { desc = "Hop to a char" })
  end,
}