return {
  'akinsho/bufferline.nvim',
  version = "*",
  dependencies = 'nvim-tree/nvim-web-devicons',
  config = function()
    require("bufferline").setup({
      options = {
        --- Tried to add an offset so buffer tabs would appear after the explorer but didn't work
        offsets = {
          {
            filetype = "Neo-tree",
            text = "File Explorer",
            text_align = "center",
            separator = true
          },
        },
      }
    })
  end,
  -- enabled = false,
}
