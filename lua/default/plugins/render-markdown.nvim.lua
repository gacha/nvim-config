return {
  "MeanderingProgrammer/render-markdown.nvim",
  ft = { "markdown", "codecompanion" },
  config = function()
    require('render-markdown').setup({
      -- Render in every mode
      render_modes = true,
      anti_conceal = {
        -- Reveal raw markdown only where it is being edited, so content does not shift as the cursor moves.
        enabled = true,
        disabled_modes = { 'n', 'no', 'c' },
      },
      win_options = {
        -- Inline code backticks, setext heading underlines and table padding are
        -- hidden with Neovim's conceal feature, which concealcursor controls. Keep
        -- them concealed on the cursor line in normal and command mode; insert and
        concealcursor = { rendered = 'nc' },
      },
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
