-- Hide tab symbol
vim.api.nvim_create_autocmd( "FileType", {
  pattern = "go",
  callback = function()
    vim.opt.listchars:append({ tab = '  ' })
  end
})
-- Set correct filetype
vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
    group = vim.api.nvim_create_augroup('detect_gotmpl', { clear = true }),
    desc = 'Set filetype for gotmpl files',
    pattern = "*.tmpl, *.gohtml, *.gotmpl",
    callback = function()
        vim.bo.filetype = 'gotmpl'
    end,
})
