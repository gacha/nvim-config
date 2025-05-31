vim.g.mapleader = ','
vim.g.maplocalleader = '\\'

local opts = {noremap = true, expr = true}

vim.keymap.set('i', 'jj', '<ESC>')
vim.keymap.set('n', 'fs', '1z=') -- Fix spelling
vim.keymap.set('n', '<S-Left>', '<cmd>foldclose<cr>')
vim.keymap.set('n', '<S-Right>', '<cmd>foldopen<cr>')
vim.keymap.set('n', '<leader>w', '<cmd>write<cr>')
vim.keymap.set('n', '<leader>v', '<cmd>vsplit<cr>')
vim.keymap.set('n', '<leader>h', '<cmd>set hlsearch!<cr>')
vim.keymap.set('n', '<leader>q', '<cmd>q<cr>')
vim.keymap.set('n', '<leader>r', '<cmd>GrugFar<cr>')
vim.keymap.set({'n', 'x'}, '<leader>y', '"+y')
vim.keymap.set({'n', 'x'}, '<leader>p', '"+p')
vim.keymap.set('i', '<Tab>',   [[pumvisible() ? "\<C-n>" : "\<Tab>"]],   opts)
vim.keymap.set('i', '<S-Tab>', [[pumvisible() ? "\<C-p>" : "\<S-Tab>"]], opts)
vim.keymap.set('n', 'gl', function()
  vim.diagnostic.open_float(0, {scope = 'line', close_events = {'CursorMoved', 'CursorMovedI', 'BufHidden', 'InsertCharPre', 'WinLeave'}})
end)
