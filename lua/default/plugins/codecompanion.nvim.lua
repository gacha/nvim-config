local gemini_pro = {
  name = "gemini",
  model = "gemini-2.5-pro"
}

return {
  'olimorris/codecompanion.nvim',
  dependencies = {
    'nvim-lua/plenary.nvim',
  },
  opts = {
    strategies = {
      chat = {
        adapter = gemini_pro,
        keymaps = {
          send = {
            modes = { n = "<Leader><CR>", i = "<C-s>" },
            opts = {},
          },
        },
      },
      inline = {
        adapter = gemini_pro,
      },
      cmd = {
        adapter = gemini_pro,
      },
    },
    opts = {
      -- log_level = "DEBUG",
    },
  },
}
