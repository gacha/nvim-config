vim.g.mapleader = ','
vim.g.maplocalleader = '\\'

local opts = {noremap = true, expr = true}

vim.keymap.set('i', 'jj', '<ESC>', { desc = 'Exit insert mode' })
vim.keymap.set('n', '<leader>fs', '1z=', { desc = 'Fix spelling' })
vim.keymap.set('n', '<S-Left>', '<cmd>foldclose<cr>', { desc = 'Close fold' })
vim.keymap.set('n', '<S-Right>', '<cmd>foldopen<cr>', { desc = 'Open fold' })
vim.keymap.set('n', '<leader>w', '<cmd>write<cr>', { desc = 'Write file' })
vim.keymap.set('n', '<leader>v', '<cmd>vsplit<cr>', { desc = 'Vertical split' })
vim.keymap.set('n', '<leader>h', '<cmd>split<cr>', { desc = 'Horizontal split' })
vim.keymap.set('n', '<leader><leader>h', '<cmd>set hlsearch!<cr>', { desc = 'Toggle highlight search' })
vim.keymap.set('n', '<leader>q', '<cmd>q<cr>', { desc = 'Quit' })
vim.keymap.set('n', '<leader><leader>q', '<cmd>tabclose<cr>', { desc = 'Close the whole tab' })
vim.keymap.set('n', '<leader>c', '<cmd>cclose<cr>', { desc = 'Close quickfix' })
vim.keymap.set('n', '<leader>g', '<cmd>G | only<cr>', { desc = 'Open Git' })
vim.keymap.set({'n', 'x'}, '<leader>y', '"+y', { desc = 'Copy to clipboard' })
vim.keymap.set({'n', 'x'}, '<leader>p', '"+p', { desc = 'Paste from clipboard' })
vim.keymap.set('i', '<Tab>',   [[pumvisible() ? "\<C-n>" : "\<Tab>"]],   vim.tbl_extend('force', opts, { desc = 'Next completion' }))
vim.keymap.set('i', '<S-Tab>', [[pumvisible() ? "\<C-p>" : "\<S-Tab>"]], vim.tbl_extend('force', opts, { desc = 'Prev completion' }))

-- Diagnostics
local diagnostic_open_float = function()
  vim.diagnostic.open_float(0, {scope = 'line', close_events = {'CursorMoved', 'CursorMovedI', 'BufHidden', 'InsertCharPre', 'WinLeave'}})
end

vim.keymap.set('n', 'gl', function()
  diagnostic_open_float()
end, { desc = 'Show line diagnostics' })
vim.keymap.set('n', '[d', function()
  vim.diagnostic.goto_prev()
  diagnostic_open_float()
end, { desc = 'Go to previous diagnostic' })
vim.keymap.set('n', ']d', function()
  vim.diagnostic.goto_next()
  diagnostic_open_float()
end, { desc = 'Go to next diagnostic' })
