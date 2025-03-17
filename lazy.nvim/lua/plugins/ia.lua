vim.g.augment_workspace_folders = { '~/repos/dotfiles' }
-- If :Augment signin doesn't display the auth link, disable all plugins but this one and try again
return {
  {
    'augmentcode/augment.vim',
    config = function()
      local wk = require("which-key")
      wk.add({
        { "<leader>i",  group = "IA" },
        { "<leader>ic", "<cmd>Augment chat<cr>",        desc = "Chat",              mode = "n" },
        { "<leader>in", "<cmd>Augment chat-new<cr>",    desc = "New chat",          mode = "n" },
        { "<leader>it", "<cmd>Augment chat-toggle<cr>", desc = "Toggle chat",       mode = "n" },
        { "<C-y>",      "<cmd>call augment#Accept()<cr>", desc = "Accept suggestion", mode = "i" },
      })
    end,
  },
}
