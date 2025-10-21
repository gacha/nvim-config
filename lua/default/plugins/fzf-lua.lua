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
      },
      grep = {
        rg_glob = true,
        -- PATCH: allow to search with glob in particular path, like: FIXME -- *.rb ./some_dir
        rg_glob_fn = function(query, opts)
          local utils = require "fzf-lua.utils"
          local libuv = require "fzf-lua.libuv"

          if not query or not query:find(opts.glob_separator) then
            return query, nil
          end

          local path_args = ""
          local glob_args = ""
          local search_query, glob_str = query:match("(.*)" .. opts.glob_separator .. "(.*)")

          for _, s in ipairs(utils.strsplit(glob_str, "%s+")) do
            if #s > 0 then
              if path_args == "" and s:sub(1, 2) == "./" then
                path_args = " " .. libuv.shellescape(s)
              else
                glob_args = glob_args .. ("%s %s "):format(opts.glob_flag, libuv.shellescape(s))
              end
            end
          end
          return search_query, glob_args .. path_args
        end
      }
    }
    vim.keymap.set('n', '<C-p>', fzf_lua.builtin, { silent = true })
    vim.keymap.set('n', '<C-f>', fzf_lua.files, { silent = true })
    vim.keymap.set('n', '<C-s>', function() fzf_lua.live_grep() end, { silent = true })
    vim.keymap.set('n', '<C-a>', function() fzf_lua.live_grep({ resume=true }) end, { silent = true })
    vim.keymap.set('n', '<C-e>', fzf_lua.buffers, { silent = true })
    vim.keymap.set('n', '<C-q>', function() fzf_lua.fill_quickfix() end, { silent = true })
    vim.keymap.set('n', '<C-t>', fzf_lua.tabs, { silent = true })
    vim.keymap.set('n', '<leader>t', fzf_lua.btags, { silent = true })
    vim.keymap.set('n', '<leader>f', fzf_lua.lsp_document_symbols, { silent = true })
    vim.keymap.set('n', '<leader>.', fzf_lua.tags, { silent = true })
    vim.keymap.set('n', 'gd', fzf_lua.lsp_definitions, { silent = true })
    vim.keymap.set('n', 'gi', fzf_lua.lsp_implementations, { silent = true })
    vim.keymap.set('n', 'gr', fzf_lua.lsp_references, { silent = true, noremap = true })
    -- jump to first definition, without LSP uses ctags
    vim.keymap.set('n', '<C-]>', function()
        if #vim.lsp.get_active_clients({ bufnr = 0 }) > 0 then
          fzf_lua.lsp_definitions({ jump1 = true })
        else
          -- do the default action if no LSP clients attached
          vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes('<C-]>', true, false, true), 'n', false)
        end
      end, {silent = true})
  end
}
