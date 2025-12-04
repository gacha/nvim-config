local default_adapter = {
  name = "copilot",
  model = "gpt-5-codex"
}

return {
  'olimorris/codecompanion.nvim',
  dependencies = {
    'nvim-lua/plenary.nvim',
  },
  config = function ()
    require("codecompanion").setup({
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
    })

    -- Expand 'cc' into 'CodeCompanion' in the command line
    vim.cmd([[cab cc CodeCompanion]])

    -- Mapping
    vim.keymap.set("v", "ga", "<cmd>CodeCompanionChat Add<cr>", { noremap = true, silent = true })
    vim.keymap.set('n', '<leader>a', '<cmd>CodeCompanionChat Toggle<cr>')
  end
}
