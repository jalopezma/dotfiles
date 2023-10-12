-- :FormatJSON to use it. Requires python installed
-- <line1> is the starting line of the command range (see ‘:help <line1>`)
-- <line2> is the final line of the command range (see ‘:help <line2>`)
-- ! here indicates this is a filter to apply to the selected text (see :help filter)
vim.api.nvim_create_user_command(
  'FormatJSON',
  '<line1>,<line2>!python -m json.tool',
  { range = true, desc = 'Format JSON files' }
)

vim.api.nvim_create_user_command(
  'Gdiff',
  'Gvdiffsplit',
  { desc = 'Git diff current file' }
)
