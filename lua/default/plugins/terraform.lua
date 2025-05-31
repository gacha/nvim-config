return {'hashivim/vim-terraform',
  config = function()
    vim.g.terraform_fmt_on_save = 1

    -- Force some filetypes
    vim.api.nvim_create_autocmd(
      { "BufRead", "BufNewFile", "FileType" },
      { pattern = { "*.sh.tftpl" }, command = "set filetype=sh" }
    )
  end
}
