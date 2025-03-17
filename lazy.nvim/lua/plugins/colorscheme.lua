return {
  -- the colorscheme should be available when starting Neovim
  {
    'folke/tokyonight.nvim',
    lazy = false,    -- make sure we load this during startup if it is your main colorscheme
    enabled = false,
    priority = 1000, -- make sure to load this before all the other start plugins
    config = function()
      -- load the colorscheme here
      vim.cmd([[colorscheme tokyonight]])
    end,
  },
  {
    'catppuccin/nvim',
    -- enabled = false,
    lazy = false,
    name = 'catppuccin',
    priority = 1000,
    config = function()
      -- load the colorscheme here
      vim.cmd([[colorscheme catppuccin-macchiato]])
    end,
  },
}
