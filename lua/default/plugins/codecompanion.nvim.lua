local default_adapter = {
  name = "copilot",
  model = "auto"
}

return {
  'olimorris/codecompanion.nvim',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'ravitemer/codecompanion-history.nvim'
  },
  config = function ()
    require("codecompanion").setup({
      display = {
        chat = {
          window = {
            -- 0 means auto
            width = 0,
            height = 0,
            -- This fixes issue with auto-width (open CC Chat as third split)
            full_height = false,
          },
        },
      },
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
            system_prompt = function(ctx)
              return ctx.default_system_prompt .. [[
                Output:
                - Your output is rendered in a Neovim split that is 100 characters wide.
                - Keep lines and tables under 100 characters; never rely on horizontal scrolling.
                - If table data would exceed that width, use lists instead.]]
            end,
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
        cli = {
          agent = "copilot",
          agents = {
            copilot = {
              cmd = "copilot",
              args = {},
              description = "Copilot CLI",
              provider = "terminal",
            },
            gemini = {
              cmd = "gemini",
              args = {},
              description = "Gemini CLI",
              provider = "terminal",
            },
            claude_code = {
              cmd = "claude",
              args = {},
              description = "Claude Code CLI",
              provider = "terminal",
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
                model = "auto-gemini-3",
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

    -- Save the windows dimensions
    local cc_win = require("codecompanion.config").display.chat.window
    vim.api.nvim_create_autocmd("WinResized", {
      callback = function()
        for _, winid in ipairs(vim.v.event.windows or {}) do
          if vim.api.nvim_win_is_valid(winid) then
            local buf = vim.api.nvim_win_get_buf(winid)
            if vim.bo[buf].filetype == "codecompanion" then
              cc_win.width = vim.api.nvim_win_get_width(winid)
              cc_win.height = vim.api.nvim_win_get_height(winid)
            end
          end
        end
      end,
    })

    -- Expand 'cc' into 'CodeCompanion' in the command line
    vim.cmd([[cab cc CodeCompanion]])

    -- Mapping
    vim.keymap.set("v", "ga", "<cmd>CodeCompanionChat Add<cr>", { desc = "Add visual selection to the current AI chat buffer", noremap = true, silent = true })
    vim.keymap.set('n', '<leader>a', '<cmd>CodeCompanionChat Toggle<cr>', { desc = "Toggle AI chat buffer" })
  end
}
