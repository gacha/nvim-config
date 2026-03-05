return {
  'gbprod/yanky.nvim',
  config = function()
    require("yanky").setup()
    vim.keymap.set({"n","x"}, "p", "<Plug>(YankyPutAfter)", {desc = "Put after cursor"})
    vim.keymap.set({"n","x"}, "P", "<Plug>(YankyPutBefore)", {desc = "Put before cursor"})
    vim.keymap.set('n', '<leader>n', '<Plug>(YankyCycleForward)', {desc = "Cycle to next yank"})
    vim.keymap.set('n', '<leader>N', '<Plug>(YankyCycleBackward)', {desc = "Cycle to previous yank"})
  end
}
