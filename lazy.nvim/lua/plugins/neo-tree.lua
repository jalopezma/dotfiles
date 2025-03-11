-- get_root function from https://github.com/LazyVim/LazyVim/blob/6f6d58799895e0b76dec7feb241709c494007390/lua/lazyvim/util/init.lua#L56
local root_patterns = { ".git", "lua" }
local function get_root()
  ---@type string?
  local path = vim.api.nvim_buf_get_name(0)
  path = path ~= "" and vim.loop.fs_realpath(path) or nil
  ---@type string[]
  local roots = {}
  if path then
    for _, client in pairs(vim.lsp.get_active_clients({ bufnr = 0 })) do
      local workspace = client.config.workspace_folders
      local paths = workspace and vim.tbl_map(function(ws)
        return vim.uri_to_fname(ws.uri)
      end, workspace) or client.config.root_dir and { client.config.root_dir } or {}
      for _, p in ipairs(paths) do
        local r = vim.loop.fs_realpath(p)
        if path:find(r, 1, true) then
          roots[#roots + 1] = r
        end
      end
    end
  end
  table.sort(roots, function(a, b)
    return #a > #b
  end)
  ---@type string?
  local root = roots[1]
  if not root then
    path = path and vim.fs.dirname(path) or vim.loop.cwd()
    ---@type string?
    root = vim.fs.find(root_patterns, { path = path, upward = true })[1]
    root = root and vim.fs.dirname(root) or vim.loop.cwd()
  end
  ---@cast root string
  return root
end

return {
  'nvim-neo-tree/neo-tree.nvim',
  branch = 'v3.x',
  cmd = 'Neotree',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-tree/nvim-web-devicons', -- not strictly required, but recommended
    'MunifTanjim/nui.nvim',
  },
  deactivate = function()
    vim.cmd([[Neotree close]])
  end,
  init = function()
    if vim.fn.argc() == 1 then
      local stat = vim.loop.fs_stat(vim.fn.argv(0))
      if stat and stat.type == 'directory' then
        require('neo-tree')
      end
    end
  end,
  -- enabled = false,
  keys = {
    {
      '<leader>E',
      function()
        require('neo-tree.command').execute({ toggle = true, dir = get_root() })
      end,
      desc = 'Explorer NeoTree (root dir)',
    },
    {
      '<leader>e',
      function()
        require('neo-tree.command').execute({ toggle = true, dir = vim.loop.cwd() })
      end,
      desc = 'Explorer NeoTree (cwd)',
    },
  },
  opts = {
    sources = { 'filesystem', 'buffers', 'git_status', 'document_symbols' },
    open_files_do_not_replace_types = { 'terminal', 'Trouble', 'qf', 'Outline' },
    default_component_configs = {
      indent = {
        with_expanders = true, -- if nil and file nesting is enabled, will enable expanders
        expander_collapsed = '',
        expander_expanded = '',
        expander_highlight = 'NeoTreeExpander',
      },
    },
    source_selector = {
      winbar = true,
    },
    window = {
      width = 50,
      mappings = {
        ['<space>'] = {
          'toggle_node',
          nowait = false, -- disable `nowait` if you have existing combos starting with this char that you want to use
        },
        ['<cr>'] = 'open',
        ['<esc>'] = 'cancel', -- close preview or floating neo-tree window
        ['p'] = { 'toggle_preview', config = { use_float = true } },
        ['P'] = 'focus_preview',
        ['S'] = 'open_split',
        ['s'] = 'open_vsplit',
        ['t'] = 'open_tabnew',
        ['C'] = 'close_node',
        ['z'] = 'close_all_nodes',
        ['Z'] = 'expand_all_nodes',
        ['r'] = 'rename',
        ['y'] = 'copy_to_clipboard',
        ['q'] = 'close_window',
        ['R'] = 'refresh',
        ['?'] = 'show_help',
        ['<'] = 'prev_source',
        ['>'] = 'next_source',
        ['h'] = function(state)
          local node = state.tree:get_node()
          if node.type == 'directory' and node:is_expanded() then
            require 'neo-tree.sources.filesystem'.toggle_directory(state, node)
          else
            require 'neo-tree.ui.renderer'.focus_node(state, node:get_parent_id())
          end
        end,
        ['l'] = function(state)
          local node = state.tree:get_node()
          if node.type == 'directory' then
            if not node:is_expanded() then
              require 'neo-tree.sources.filesystem'.toggle_directory(state, node)
            elseif node:has_children() then
              require 'neo-tree.ui.renderer'.focus_node(state, node:get_child_ids()[1])
            end
          end
        end,
      }
    },
    filesystem = {
      bind_to_cwd = false,
      follow_current_file = { enabled = true },
      use_libuv_file_watcher = true,
      filtered_items = {
        hide_dotfiles = false,
        hide_gitignored = true,
        hide_hidden = true, -- only works on Windows for hidden files/directories
        hide_by_name = {
          --'node_modules'
        },
        hide_by_pattern = { -- uses glob style patterns
          --'*.meta',
          --'*/src/*/tsconfig.json',
        },
        always_show = { -- remains visible even if other settings would normally hide it
          --'.gitignored',
        },
        never_show = { -- remains hidden even if visible is toggled to true, this overrides always_show
          --'.DS_Store',
          --'thumbs.db'
        },
        never_show_by_pattern = { -- uses glob style patterns
          --'.null-ls_*',
        },
      },
      window = {
        mappings = {
          ['<bs>'] = 'navigate_up',
          ['.'] = 'set_root',
          ['H'] = 'toggle_hidden',
          ['/'] = 'fuzzy_finder',
          ['f'] = 'filter_on_submit',
          ['<c-x>'] = 'clear_filter',
          ['o'] = { 'show_help', nowait = false, config = { title = 'Order by', prefix_key = 'o' } },
        },
      },
    },
    buffers = {
      show_unloaded = true,
      window = {
        mappings = {
          ['bd'] = 'buffer_delete',
          ['<bs>'] = 'navigate_up',
          ['.'] = 'set_root',
          ['o'] = { 'show_help', nowait = false, config = { title = 'Order by', prefix_key = 'o' } },
        }
      },
    },
  },
  config = function(_, opts)
    -- If you want icons for diagnostic errors, you'll need to define them somewhere:
    vim.fn.sign_define('DiagnosticSignError', { text = ' ', texthl = 'DiagnosticSignError' })
    vim.fn.sign_define('DiagnosticSignWarn', { text = ' ', texthl = 'DiagnosticSignWarn' })
    vim.fn.sign_define('DiagnosticSignInfo', { text = ' ', texthl = 'DiagnosticSignInfo' })
    vim.fn.sign_define('DiagnosticSignHint', { text = '󰌵', texthl = 'DiagnosticSignHint' })

    require("neo-tree").setup(opts)
  end,
}
