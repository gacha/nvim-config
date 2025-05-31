return {
  'lifepillar/vim-gruvbox8',
  branch = 'neovim',
  lazy = false,
  priority = 1000,
  config = function()
    vim.g.background = 'dark'
    vim.cmd.colorscheme('gruvbox8_soft')
    vim.api.nvim_set_hl(0, 'NormalFloat', {bg = 'none',})
  end
}
