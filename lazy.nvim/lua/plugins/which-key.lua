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
  },
  config = function()
    local wk = require('which-key')

    wk.register({
      ['<leader>'] = {
        f = { name = 'File' },
        w = { name = 'Windows' },
        g = { name = 'Git' },
        s = { name = 'search' },
        b = { name = 'buffers' },
      },
      g = {
        name = 'go to',
      },
    }, { mode = 'n' })
  end,
}
