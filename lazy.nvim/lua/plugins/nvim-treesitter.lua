return {
  'nvim-treesitter/nvim-treesitter',
  build = ':TSUpdate',
  -- enabled = false,
  config = function()
    require('nvim-treesitter.configs').setup {
      ensure_installed = {
        'css', 'html', 'javascript', 'lua', 'python', 'tsx', 'typescript', 'vim',
      },
      highlight = {
        enable = true,
      },
      context_commentstring = {
        enable = true,
        enable_autocmd = false,
      },
    }
  end,
  dependencies = {
    'JoosepAlviste/nvim-ts-context-commentstring',
    -- to allow numToStr/Comment.nvim comment plugin to work
  },
}
