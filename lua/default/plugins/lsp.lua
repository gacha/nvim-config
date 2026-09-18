return {
  'williamboman/mason.nvim',
  dependencies = {
    'williamboman/mason-lspconfig.nvim',
    'neovim/nvim-lspconfig',
  },
  config = function ()
    -- Global
    vim.lsp.inlay_hint.enable(false)

    -- Disable CodeLens for all language servers
    vim.api.nvim_create_autocmd('LspAttach', {
      callback = function(args)
        local client = vim.lsp.get_client_by_id(args.data.client_id)
        if client then
          client.server_capabilities.codeLensProvider = nil
        end
      end,
    })

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
