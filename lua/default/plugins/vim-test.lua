return {
  'vim-test/vim-test',
  config = function()
    vim.g['test#strategy'] = 'neovim_sticky'
    vim.g['test#echo_command'] = 0
    vim.keymap.set('n', '<leader>R', ':TestNearest<CR>', {silent = true, desc = 'Run nearest test'})
    vim.keymap.set('n', '<leader>T', ':TestFile<CR>',    {silent = true, desc = 'Run test file'})
    vim.keymap.set('n', '<leader>A', ':TestSuite<CR>',   {silent = true, desc = 'Run test suit'})
    vim.keymap.set('n', '<leader>L', ':TestLast<CR>',    {silent = true, desc = 'Re-run last test'})
  end
}
