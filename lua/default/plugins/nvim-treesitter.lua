return {
  'nvim-treesitter/nvim-treesitter',
  lazy = false,
  build = ':TSUpdate',
  config = function()
    require('nvim-treesitter').install { 'html', 'ruby', 'javascript', 'go', 'c', 'lua', 'vim', 'vimdoc', 'bash', 'yaml', 'diff' }
  end,
}
