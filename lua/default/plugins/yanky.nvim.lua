return {
  'gbprod/yanky.nvim',
  config = function()
    require("yanky").setup()
    vim.keymap.set({"n","x"}, "p", "<Plug>(YankyPutAfter)")
    vim.keymap.set({"n","x"}, "P", "<Plug>(YankyPutBefore)")
    vim.keymap.set('n', '<leader>n', '<Plug>(YankyCycleForward)')
    vim.keymap.set('n', '<leader>N', '<Plug>(YankyCycleBackward)')
  end
}
