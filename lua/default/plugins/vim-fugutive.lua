return {
  'tpope/vim-fugitive',
  dependencies =  {
    'tpope/vim-rhubarb',
  },
  config = function()
    vim.g.fugitive_summary_format = '%cs | %<(20,trunc)%an | %s'

    vim.keymap.set('n', '<leader>gh', '<cmd>Git log --no-merges -p %<cr>', { desc = 'Show git history for current file' })
    vim.keymap.set('n', '<leader>go', '<cmd>GBrowse<cr>', { desc = 'Open file in GitHub' })
    vim.keymap.set('n', '<leader>gb', '<cmd>Git blame<cr>', { desc = 'Show git blame' })
  end
}
