return {
  'tpope/vim-fugitive',
  dependencies =  {
    'tpope/vim-rhubarb',
  },
  config = function()
    vim.g.fugitive_summary_format = '%cs | %<(20,trunc)%an | %s'

    vim.keymap.set('n', '<leader>gh', '<cmd>Git log --no-merges -p %<cr>')
    vim.keymap.set('n', '<leader>go', '<cmd>GBrowse<cr>')
    vim.keymap.set('n', '<leader>gb', '<cmd>Git blame<cr>')
  end
}
