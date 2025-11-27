return {
  'williamboman/mason.nvim',
  dependencies = {
    'williamboman/mason-lspconfig.nvim',
    'neovim/nvim-lspconfig',
  },
  config = function ()
    -- Global
    vim.lsp.codelens = false

    -- Mason
    require('mason').setup()
    require('mason-lspconfig').setup {
      ensure_installed = {
        'rubocop', 'ruby_lsp', 'lua_ls', 'bashls',
        'gopls', 'terraformls', 'tflint', 'quick_lint_js'
      },
    }
    -- LUA
    vim.lsp.config('lua_ls', {
      settings = {
        lens = {
          enable = false
        },
        Lua = {
          diagnostics = {
            -- Get the language server to recognize the `vim` global
            globals = {'vim'},
          },
        },
      },
    })
  end
}
