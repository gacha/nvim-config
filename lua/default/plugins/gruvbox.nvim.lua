return {
  'ellisonleao/gruvbox.nvim', priority = 1000 , config = true,
  config = function()
    require("gruvbox").setup()
    vim.opt.background = "dark" -- or "light" for light mode
    vim.cmd("colorscheme gruvbox")
  end
}
