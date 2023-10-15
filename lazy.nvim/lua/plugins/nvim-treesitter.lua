return {
  'nvim-treesitter/nvim-treesitter',
  build = ':TSUpdate',
  -- enabled = false,
  config = function()
    require('nvim-treesitter.configs').setup {
      ensure_installed = {
        'bash', 'cmake', 'css', 'csv', 'dockerfile', 'git_config', 'git_rebase', 'gitattributes', 'gitcommit',
        'gitignore', 'go', 'gomod', 'gosum', 'gpg', 'groovy', 'haskell', 'html', 'http', 'javascript', 'jq', 'jsdoc',
        'json', 'lua', 'luadoc', 'make', 'markdown', 'markdown_inline', 'nix', 'python', 'regex', 'requirements', 'scss',
        'sql', 'ssh_config', 'tsv', 'tsx', 'typescript', 'vim', 'vimdoc', 'vim', 'xml', 'yaml'
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
