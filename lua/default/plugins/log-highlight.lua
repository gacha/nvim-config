return {
  'fei6409/log-highlight.nvim',
  config = function()
    require('log-highlight').setup {
      pattern = {
        '.*%.log%.%d+'
      }
    }
  end,
}
