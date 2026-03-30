return {
  'nvim-treesitter/nvim-treesitter',
  lazy = false,
  build = ':TSUpdate',
  dependencies = {
    'RRethy/nvim-treesitter-endwise',
  },
  config = function()
    require('nvim-treesitter').install { 'html', 'ruby', 'javascript', 'go', 'c', 'lua', 'vim', 'vimdoc', 'bash', 'yaml', 'diff'}
    -- require('nvim-treesitter.configs').setup({
    --   highlight = {
    --     enable = true,
    --     disable = {'terraform', 'coffee'},
    --   },
    --   endwise = {
    --     enable = true,
    --   },
    --   indent = {
    --     enable = true,
    --   },
    -- })
    -- FIX: this is a workaround for an indent bug https://github.com/nvim-treesitter/nvim-treesitter/issues/3363
    -- vim.cmd('autocmd FileType ruby setlocal indentkeys-=.')
  end
}
