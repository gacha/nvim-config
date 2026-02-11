return {
  "lewis6991/gitsigns.nvim",
  dependencies = {
    "tpope/vim-fugitive",
  },
  config = function ()
    require('gitsigns').setup {}
  end
}
