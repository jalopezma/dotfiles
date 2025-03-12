return {
  'folke/which-key.nvim',
  event = 'VeryLazy',
  -- enabled = false,
  init = function()
    vim.o.timeout = true
    vim.o.timeoutlen = 300
  end,
  opts = {
    -- your configuration comes here
    -- or leave it empty to use the default settings
    -- refer to the configuration section below
    ---@type false | "classic" | "modern" | "helix"
    preset = "classic",
  },
  config = function()
    local wk = require('which-key')

    wk.add({
      {'<leader>f', group = 'File' },
      {'<leader>w', group = 'Windows' },
      {'<leader>g', group = 'Git' },
      {'<leader>s', group = 'search' },
      {'<leader>b', group = 'buffers' },
      { 'g', group = 'go to' },
    }, { mode = 'n' })
  end,
}
