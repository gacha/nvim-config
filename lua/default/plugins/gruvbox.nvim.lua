return {
  'ellisonleao/gruvbox.nvim', priority = 1000,
  config = function()
    require("gruvbox").setup({
      italic = {
        comments = true,
        strings = false,
        operators = false
      },
      contrast = "",
      transparent_mode = false,
    })
    vim.cmd("colorscheme gruvbox")
  end
}
