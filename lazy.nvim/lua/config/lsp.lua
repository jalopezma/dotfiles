local icons = {
  Array = ' ',
  Boolean = ' ',
  Class = ' ',
  Color = ' ',
  Constant = ' ',
  Constructor = ' ',
  Copilot = ' ',
  Enum = ' ',
  EnumMember = ' ',
  Event = ' ',
  Field = ' ',
  File = ' ',
  Folder = ' ',
  Function = ' ',
  Interface = ' ',
  Key = ' ',
  Keyword = ' ',
  Method = ' ',
  Module = ' ',
  Namespace = ' ',
  Null = ' ',
  Number = ' ',
  Object = ' ',
  Operator = ' ',
  Package = ' ',
  Property = ' ',
  Reference = ' ',
  Snippet = ' ',
  String = ' ',
  Struct = ' ',
  Text = ' ',
  TypeParameter = ' ',
  Unit = ' ',
  Value = ' ',
  Variable = ' ',
}

-- Init Mason
local lsp_zero = require('lsp-zero')
-- Add here any LSP you want to enable
local lsp_servers = {
  'lua_ls', 'bashls', 'ts_ls', 'pyright', 'dockerls', 'docker_compose_language_service',
  'jsonls', 'yamlls',
}
lsp_zero.extend_cmp()
require('mason').setup({})
require('mason-lspconfig').setup({
  -- Only LSP, no formatters nor linters
  ensure_installed = lsp_servers,
  automatic_installation = true,
  handlers = {
    lsp_zero.default_setup,
  },
})

-- Add some keymaps for autocompletion menu
local cmp = require('cmp')
local luasnip = require('luasnip')
local defaults = require('cmp.config.default')()

local has_words_before = function()
  unpack = unpack or table.unpack
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match('%s') == nil
end

cmp.setup({
  completion = {
    completeopt = 'menu,menuone,noinsert',
  },
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
  mapping = cmp.mapping.preset.insert({
    ['<C-n>'] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
    ['<C-p>'] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),

    -- Ctrl+Space to trigger completion menu
    ['<C-Space>'] = cmp.mapping.complete(),
    --  Close it
    ['<esc>'] = cmp.mapping.abort(),
    ['<C-e>'] = cmp.mapping.abort(),

    -- `Enter` key to confirm completion
    ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.

    -- Scroll up and down in the completion documentation
    ['<C-u>'] = cmp.mapping.scroll_docs(-4),
    ['<C-d>'] = cmp.mapping.scroll_docs(4),

    ['<Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
        -- You could replace the expand_or_jumpable() calls with expand_or_locally_jumpable()
        -- they way you will only jump inside the snippet region
      elseif luasnip.expand_or_locally_jumpable() then
        luasnip.expand_or_jump()
      elseif has_words_before() then
        cmp.complete()
      else
        fallback()
      end
    end, { 'i', 's' }),

    ['<S-Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, { 'i', 's' }),
  }),
  sources = cmp.config.sources({
    { name = 'nvim_lsp' },
    { name = 'luasnip' },
    { name = 'buffer' },
    { name = 'path' },
  }),
  formatting = {
    format = function(_, item)
      if icons[item.kind] then
        item.kind = icons[item.kind] .. item.kind
      end
      return item
    end,
  },
  -- As long as the `formatting` property above works, I don't need the one below
  -- formatting = lsp_zero.cmp_format(),
  experimental = {
    ghost_text = {
      hl_group = 'CmpGhostText',
    },
  },
  sorting = defaults.sorting,
  cmdline = {},
})

-- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline({ '/', '?' }, {
  mapping = cmp.mapping.preset.cmdline(),
  sources = {
    { name = 'buffer' }
  }
})

-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline(':', {
  mapping = cmp.mapping.preset.cmdline(),
  sources = cmp.config.sources({
    { name = 'path' }
  }, {
    {
      name = 'cmdline',
      option = {
        ignore_cmds = { 'Man', '!' }
      }
    }
  })
})

-- Adds diagnositcs signs on the line number column
-- !important nerdfonts needs to be setup for this to work in your terminal
local signs = { Error = ' ', Warn = ' ', Hint = ' ', Info = ' ' }
for type, icon in pairs(signs) do
  local hl = 'DiagnosticSign' .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end

-- Format/linting with LSP
local null_ls = require("null-ls")
null_ls.setup({
  sources = {
    null_ls.builtins.formatting.terraform_fmt,
    null_ls.builtins.formatting.prettierd,
    null_ls.builtins.formatting.shfmt.with({
      extra_args = { "-i", "2", "-ci" },
    }),

    null_ls.builtins.diagnostics.checkmake, -- make
    null_ls.builtins.diagnostics.dotenv_linter,
    null_ls.builtins.diagnostics.hadolint, -- docker
    null_ls.builtins.diagnostics.markdownlint_cli2,
    null_ls.builtins.diagnostics.sqlfluff.with({
      extra_args = { "--dialect", "databricks" },
    }),
    null_ls.builtins.diagnostics.write_good,
    require("none-ls.diagnostics.eslint_d"),

    null_ls.builtins.code_actions.gitsigns,
    require("none-ls.code_actions.eslint_d"),

    --null_ls.builtins.hover.dictionary,
    null_ls.builtins.hover.printenv,

    null_ls.builtins.completion.spell,
  },
})
