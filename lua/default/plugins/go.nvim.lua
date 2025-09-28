return {
  'ray-x/go.nvim',
  dependencies = {  -- optional packages
    'ray-x/guihua.lua',
    'neovim/nvim-lspconfig',
    'nvim-treesitter/nvim-treesitter',
  },
  config = function()
    require('go').setup()
    -- Run GoFormat on save
    vim.api.nvim_create_autocmd("BufWritePre", {
      pattern = "*.go",
      callback = function()
        require('go.format').gofmt()
      end,
    })
    -- Hide tab symbol
    vim.api.nvim_create_autocmd( "FileType", {
      pattern = "go",
      callback = function()
        vim.opt.listchars:append({ tab = '  ' })
      end
    })
  end,
  event = {'CmdlineEnter'},
  ft = {'go', 'gomod'},
  build = ':lua require("go.install").update_all_sync()'
}
