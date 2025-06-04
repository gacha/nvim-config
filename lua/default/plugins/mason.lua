return {
  'williamboman/mason.nvim',
  dependencies = {
    'williamboman/mason-lspconfig.nvim',
    'neovim/nvim-lspconfig',
  },
  config = function ()
    require('mason').setup()
    require('mason-lspconfig').setup {
      ensure_installed = {
        'rubocop', 'ruby_lsp', 'lua_ls', 'bashls',
        'gopls', 'terraformls', 'tflint', 'quick_lint_js'
      },
    }
  end
}
