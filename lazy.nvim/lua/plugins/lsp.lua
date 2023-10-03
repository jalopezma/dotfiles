return {
  --- To manage LSP servers from neovim
  {
    'williamboman/mason.nvim',
    -- enabled = false,
  },
  {
    'williamboman/mason-lspconfig.nvim',
    -- enabled = false,
  },

  -- Collection of functions that will help you setup Neovim's LSP client
  {
    'VonHeikemen/lsp-zero.nvim',
    branch = 'v3.x',
    lazy = true,
    config = false,
    -- enabled = false,
  },

  -- LSP Support
  {
    'neovim/nvim-lspconfig',
    dependencies = {
      { 'hrsh7th/cmp-nvim-lsp' },
    },
    -- enabled = false,
  },

  -- Autocompletion
  {
    'hrsh7th/nvim-cmp',
    version = false, -- last release is way too old
    event = 'InsertEnter',
    dependencies = {
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-buffer',
      'hrsh7th/cmp-path',
      'saadparwaiz1/cmp_luasnip',
      'L3MON4D3/LuaSnip',
    },
    opts = function()
      vim.api.nvim_set_hl(0, 'CmpGhostText', { link = 'Comment', default = true })
    end,
  },
  -- enabled = false,
}
