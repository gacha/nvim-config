return {
  'roobert/search-replace.nvim',
  config = function()
    require("search-replace").setup()
    local opts = {}
    vim.api.nvim_set_keymap("v", "<C-r>", "<CMD>SearchReplaceSingleBufferVisualSelection<CR>", opts)
  end,
}
