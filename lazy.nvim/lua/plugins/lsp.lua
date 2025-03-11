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
    init = function()
      -- Disable automatic setup, we are doing it manually
      vim.g.lsp_zero_extend_cmp = 0
      vim.g.lsp_zero_extend_lspconfig = 0
    end,
    -- enabled = false,
  },

  -- LSP Support
  {
    'neovim/nvim-lspconfig',
    cmd = 'LspInfo',
    event = { 'BufReadPre', 'BufNewFile' },
    dependencies = {
      { 'hrsh7th/cmp-nvim-lsp' },
    },
    -- enabled = false,
  },

  -- Needed as a dependency for nvim-cmp but need to run the build command
  {
    'L3MON4D3/LuaSnip',
    -- follow latest release.
    version = 'v2.*', -- Replace <CurrentMajor> by the latest released major (first number of latest release)
    -- install jsregexp (optional!).
    build = 'make install_jsregexp'
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
    cmd = 'Trouble',
    keys = {
      { 'gr',         '<cmd>Trouble lsp_references<cr>',         desc = 'reference' },
      { 'gd',         '<cmd>Trouble lsp_definitions<cr>',        desc = 'definition' },
      { 'gs',         '<cmd>vert winc ]<cr>',                    desc = 'definition in a vertical split' },
      { 'gt',         '<cmd>Trouble lsp_type_definitions<cr>',   desc = 'type definition' },
      { 'gD',         '<cmd>Trouble diagnostics<cr>',            desc = 'document diagnostics' },

      -- Move to the previous diagnostic in the current buffer. See :help vim.diagnostic.goto_prev().
      { 'gp',         function() vim.diagnostic.goto_prev() end, desc = 'previous diagnostic' },
      -- Move to the next diagnostic. See :help vim.diagnostic.goto_next().
      { 'gn',         function() vim.diagnostic.goto_next() end, desc = 'next diagnostic' },

      -- Renames all references to the symbol under the cursor. See :help vim.lsp.buf.rename().
      { '<leader>rn', function() vim.lsp.buf.rename() end,       desc = 'rename' },
      -- Displays hover information about the symbol under the cursor in a floating window. See :help vim.lsp.buf.hover().
      { '<leader>K',  function() vim.lsp.buf.hover() end,        desc = 'information' },
      -- Selects a code action available at the current cursor position. See :help vim.lsp.buf.code_action().
      { '<leader>a',  function() vim.lsp.buf.code_action() end,  desc = 'code actions' },
      -- <F3>: Format code in current buffer. See :help vim.lsp.buf.format().
      { '<leader>fo', function() vim.lsp.buf.format() end,       desc = 'format file' },
    },
    -- Needed to register the command
    opts = {},
  },

  -- Makes default neovim ui a bit better. For example for code actions and renaming symbols
  {
    'stevearc/dressing.nvim',
    opts = {},
    event = 'VeryLazy',
    -- enabled = false,
  },
}
