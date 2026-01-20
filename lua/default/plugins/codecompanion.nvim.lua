local default_adapter = {
  name = "copilot",
  model = "claude-sonnet-4.5"
}

return {
  'olimorris/codecompanion.nvim',
  dependencies = {
    'nvim-lua/plenary.nvim',
  },
  config = function ()
    require("codecompanion").setup({
      interactions = {
        chat = {
          adapter = default_adapter,
          keymaps = {
            close = {
              modes = { n = "<Leader>q" },
              opts = {},
            },
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
      rules = {
        default = {
          description = "Collection of common files for all projects",
          files = {
            "AGENTS.md",
            "*/AGENTS.md",
            { path = "CLAUDE.md", parser = "claude" },
          },
          enabled = true,
        },
        opts = {
          chat = {
            autoload = "default",
            enabled = true,
          },
        },
      },
      adapters = {
        acp = {
          gemini_cli = function()
            return require("codecompanion.adapters").extend("gemini_cli", {
              commands = {
                default = {
                  "gemini",
                  "--experimental-acp",
                },
              },
              defaults = {
                auth_method = "gemini-api-key",
                timeout = 20000
              },
            })
          end,
        },
      },
    })

    -- Expand 'cc' into 'CodeCompanion' in the command line
    vim.cmd([[cab cc CodeCompanion]])

    -- Mapping
    vim.keymap.set("v", "ga", "<cmd>CodeCompanionChat Add<cr>", { noremap = true, silent = true })
    vim.keymap.set('n', '<leader>a', '<cmd>CodeCompanionChat Toggle<cr>')
  end
}
