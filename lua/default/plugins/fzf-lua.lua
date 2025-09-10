return {
  'ibhagwan/fzf-lua',
  dependencies = {'nvim-tree/nvim-web-devicons'},
  config = function()
    local fzf_lua = require('fzf-lua')
    fzf_lua.setup {
      winopts = {
        preview = {
          vertical = 'down:70%',
          layout = 'vertical',
        }
      }
    }
    vim.keymap.set('n', '<C-p>', fzf_lua.builtin, { silent = true })
    vim.keymap.set('n', '<C-f>', fzf_lua.files, { silent = true })
    vim.keymap.set('n', '<C-s>', function() fzf_lua.live_grep({ rg_glob=true }) end, { silent = true })
    vim.keymap.set('n', '<C-a>', function() fzf_lua.live_grep({ resume=true, rg_glob=true }) end, { silent = true })
    vim.keymap.set('n', '<C-e>', fzf_lua.buffers, { silent = true })
    vim.keymap.set('n', '<C-q>', function() fzf_lua.fill_quickfix() end, { silent = true })
    vim.keymap.set('n', '<leader>t', fzf_lua.btags, { silent = true })
    vim.keymap.set('n', '<leader>f', fzf_lua.lsp_document_symbols, { silent = true })
    vim.keymap.set('n', '<leader>.', fzf_lua.tags, { silent = true })
    vim.keymap.set('n', 'gd', fzf_lua.lsp_definitions, { silent = true })
    vim.keymap.set('n', 'gi', fzf_lua.lsp_implementations, { silent = true })
    vim.keymap.set('n', 'gr', fzf_lua.lsp_references, { silent = true, noremap = true })
    -- jump to first definition, without LSP uses ctags
    vim.keymap.set('n', '<C-]>', function()
        fzf_lua.lsp_definitions({ jump1 = true })
      end, {silent = true})
  end
}
