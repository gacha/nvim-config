local default_adapter = {
  name = "copilot",
  model = "claude-haiku-4.5"
}

return {
  'olimorris/codecompanion.nvim',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'ravitemer/codecompanion-history.nvim'
  },
  config = function ()
    require("codecompanion").setup({
      prompt_library = {
        markdown = {
          dirs = {
            vim.fn.getcwd() .. "/.prompts",
            "~/.config/prompts",
          },
        },
      },
      interactions = {
        chat = {
          adapter = default_adapter,
          opts = {
            completion_provider = "cmp",
          },
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
        per_project_config = {
          files = {
            ".codecompanion.lua",
          },
        },
      },
      rules = {
        opts = {
          chat = {
            autoload = "default",
            enabled = true,
          },
        },
      },
      adapters = {
        http = {
          opts = {
            show_presets = false,
            show_model_choices = true,
          },

          copilot = "copilot",
          ollama = "ollama",
          lmstudio = function()
            return require("codecompanion.adapters").extend("openai_compatible", {
              name = "lmstudio",
              env = {
                url = "http://localhost:1234",
                -- api_key = "lmstudio",
              },
            })
          end,
        },
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
      extensions = {
        history = {
          enabled = true,
          opts = {
            auto_generate_title = false,
          },
        }
      },
    })

    -- Expand 'cc' into 'CodeCompanion' in the command line
    vim.cmd([[cab cc CodeCompanion]])

    -- Mapping
    vim.keymap.set("v", "ga", "<cmd>CodeCompanionChat Add<cr>", { desc = "Add visual selection to the current AI chat buffer", noremap = true, silent = true })
    vim.keymap.set('n', '<leader>a', '<cmd>CodeCompanionChat Toggle<cr>', { desc = "Toggle AI chat buffer" })
  end
}
