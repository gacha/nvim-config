return {
  'tpope/vim-fugitive',
  config = function()
    vim.g.fugitive_summary_format = '%cs | %<(20,trunc)%an | %s'

    vim.api.nvim_create_autocmd("FileType", {
      pattern = "qf",
      callback = function(event)
        local title = vim.fn.getqflist({ title = 0 }).title or ""
        if not title:lower():find("gclog", 1, true) then
          return
        end
        local opts = { buffer = event.buf, silent = true }
        vim.keymap.set("n", "j", "<cmd>cnext<bar>copen<cr>", opts)
        vim.keymap.set("n", "k", "<cmd>cprev<bar>copen<cr>", opts)
      end,
    })
    -- Open git history for the current buffer
    vim.keymap.set('n', '<leader><leader>g', '<cmd>GcLog --no-merges %<cr>')
  end
}
