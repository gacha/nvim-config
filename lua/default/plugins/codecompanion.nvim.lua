local default_adapter = {
  name = "copilot",
  model = "gpt-5-codex"
}

return {
  'olimorris/codecompanion.nvim',
  dependencies = {
    'nvim-lua/plenary.nvim',
  },
  opts = {
    strategies = {
      chat = {
        adapter = default_adapter,
        keymaps = {
          send = {
            modes = { n = "<Leader><CR>", i = "<C-s>" },
            opts = {},
          },
        },
      },
      inline = {
        adapter = default_adapter,
      },
      cmd = {
        adapter = default_adapter,
      },
    },
    opts = {
      -- log_level = "DEBUG",
    },
  },
}
