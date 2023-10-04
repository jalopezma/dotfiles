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
      'hrsh7th/cmp-cmdline',
      'saadparwaiz1/cmp_luasnip',
      'L3MON4D3/LuaSnip',
    },
    opts = function()
      vim.api.nvim_set_hl(0, 'CmpGhostText', { link = 'Comment', default = true })
    end,
  },

  -- Beautfier for quicklist
  {
    'folke/trouble.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    -- enabled = false,
    --[[ opts = {
      -- your configuration comes here
      -- or leave it empty to use the default settings
      -- refer to the configuration section below
    }, ]]
    event = 'VeryLazy',
    config = function()
      local map = vim.keymap.set
      map('n', 'gr', function() require('trouble').open('lsp_references') end, { desc = 'reference' })
      map('n', 'gd', function() require('trouble').open('lsp_definitions') end, { desc = 'definition' })
      map('n', 'gt', function() require('trouble').open('lsp_type_definitions') end, { desc = 'type definition' })
      map('n', 'gD', function() require('trouble').open('document_diagnostics') end, { desc = 'document diagnostics' })

      -- Move to the previous diagnostic in the current buffer. See :help vim.diagnostic.goto_prev().
      map('n', 'gp', function() vim.diagnostic.goto_prev() end, { desc = 'previous diagnostic' })
      -- Move to the next diagnostic. See :help vim.diagnostic.goto_next().
      map('n', 'gn', function() vim.diagnostic.goto_next() end, { desc = 'next diagnostic' })

      -- Renames all references to the symbol under the cursor. See :help vim.lsp.buf.rename().
      map('n', '<leader>rn', function() vim.lsp.buf.rename() end, { desc = 'rename' })
      -- Displays hover information about the symbol under the cursor in a floating window. See :help vim.lsp.buf.hover().
      map('n', '<leader>K', function() vim.lsp.buf.hover() end, { desc = 'information' })
      -- Selects a code action available at the current cursor position. See :help vim.lsp.buf.code_action().
      map('n', '<leader>a', function() vim.lsp.buf.code_action() end, { desc = 'code actions' })
      -- <F3>: Format code in current buffer. See :help vim.lsp.buf.format().
      map('n', '<leader>fo', function() vim.lsp.buf.format() end, { desc = 'format file' })

      -- to add the missing keymaps that i want here and in ./which-key.lua
      -- gi: Lists all the implementations for the symbol under the cursor in the quickfix window. See :help vim.lsp.buf.implementation().
      -- gs: Displays signature information about the symbol under the cursor in a floating window. See :help vim.lsp.buf.signature_help(). If a mapping already exists for this key this function is not bound.
      -- gl: Show diagnostics in a floating window. See :help vim.diagnostic.open_float().
    end,
  },
}
