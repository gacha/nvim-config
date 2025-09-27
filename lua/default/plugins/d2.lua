return {
  "terrastruct/d2-vim",
  dependencies = {
    "nvim-treesitter/nvim-treesitter",
    {
      "ravsii/tree-sitter-d2",
      build = "make nvim-install",
    },
  },
  ft = { "d2" },
  config = function ()
    -- Autocmd to change listchars for D2 ASCII preview buffers
    vim.api.nvim_create_autocmd("BufNew",
      {
        pattern = "D2_ASCII_PREVIEW",
        callback = function()
          -- This avoids visible characters for trailing whitespace in these specific buffers.
          vim.opt.listchars:append({ trail = " " })
          -- This hides the sign column for better look
          vim.opt.signcolumn="no"
        end,
      }
    )
  end
}
