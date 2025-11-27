return {
  'tpope/vim-fugitive',
  config = function()
    vim.g.fugitive_summary_format = '%cs | %<(20,trunc)%an | %s'

    -- Open git history for the current buffer
    vim.keymap.set('n', '<leader><leader>g', '<cmd>Git log --no-merges -p %<cr>')
  end
}
