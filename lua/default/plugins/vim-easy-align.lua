return {'junegunn/vim-easy-align',
  config = function()
    vim.keymap.set('x', 'ea', '<Plug>(EasyAlign)', {desc = 'Align text'})
    vim.keymap.set('n', 'ea', '<Plug>(EasyAlign)', {desc = 'Align text'})
  end
}
