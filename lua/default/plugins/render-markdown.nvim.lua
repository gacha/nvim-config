return {
  "MeanderingProgrammer/render-markdown.nvim",
  ft = { "markdown", "codecompanion" },
  config = function()
    require('render-markdown').setup({
      overrides = {
        buftype = {
          nofile = {
            padding = { highlight = 'Normal' },
          },
        },
      },
    })
  end
}
