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
        -- log_level = "DEBUG",
      },
      rules = {
        default = {
          description = "Default rule",
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
      extensions = {
        mcphub = {
          callback = "mcphub.extensions.codecompanion",
          opts = {
            -- MCP Tools
            make_tools = true,              -- Make individual tools (@server__tool) and server groups (@server) from MCP servers
            show_server_tools_in_chat = true, -- Show individual tools in chat completion (when make_tools=true)
            add_mcp_prefix_to_tool_names = false, -- Add mcp__ prefix (e.g `@mcp__github`, `@mcp__neovim__list_issues`)
            show_result_in_chat = true,      -- Show tool results directly in chat buffer
            format_tool = nil,               -- function(tool_name:string, tool: CodeCompanion.Agent.Tool) : string Function to format tool names to show in the chat buffer
            -- MCP Resources
            make_vars = true,                -- Convert MCP resources to #variables for prompts
            -- MCP Prompts
            make_slash_commands = true,      -- Add MCP prompts as /slash commands
          }
        },
        history = {
          enabled = true,
        }
      }
    })

    -- Expand 'cc' into 'CodeCompanion' in the command line
    vim.cmd([[cab cc CodeCompanion]])

    -- Mapping
    vim.keymap.set("v", "ga", "<cmd>CodeCompanionChat Add<cr>", { noremap = true, silent = true })
    vim.keymap.set('n', '<leader>a', '<cmd>CodeCompanionChat Toggle<cr>')
  end
}
