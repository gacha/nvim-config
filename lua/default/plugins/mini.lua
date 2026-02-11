return {
  'echasnovski/mini.nvim',
  version = false,
  config = function()
    require('mini.comment').setup()
    require('mini.surround').setup({
      -- Module mappings. Use `''` (empty string) to disable one.
      mappings = {
        add = 'as', -- Add surrounding in Normal and Visual modes
        delete = 'ds', -- Delete surrounding
        find = '', -- Find surrounding (to the right)
        find_left = '', -- Find surrounding (to the left)
        highlight = '', -- Highlight surrounding
        replace = 'cs', -- Replace surrounding
        suffix_last = '', -- Suffix to search with "prev" method
        suffix_next = '', -- Suffix to search with "next" method
      },
    })
  end
}
