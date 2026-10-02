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
              local win_width = vim.api.nvim_win_get_width(winid)
              local win_height = vim.api.nvim_win_get_height(winid)
              -- A horizontal split spans (almost) the full editor width
              if win_width >= vim.o.columns then
                cc_win.height = win_height
              else
                cc_win.width = win_width
              end
            end
          end
        end
      end,
    })

    -- Expand 'cc' into 'CodeCompanion' in the command line
    vim.cmd([[cab cc CodeCompanion]])

    -- Mapping
    vim.keymap.set("v", "ga", "<cmd>CodeCompanionChat Add<cr>", { desc = "Add visual selection to the current AI chat buffer", noremap = true, silent = true })
    local function smart_toggle_ai_chat()
      -- If chat is the only window, just open a clean buffer (can't close last window)
      if vim.bo.filetype == "codecompanion" and #vim.api.nvim_list_wins() == 1 then
        vim.cmd("enew")
        return
      end

      -- Check if the only open buffer is an empty unnamed one (fresh nvim start)
      local only_empty_buffer = (function()
        local listed = {}
        for _, buf in ipairs(vim.api.nvim_list_bufs()) do
          if vim.api.nvim_buf_is_valid(buf) and vim.bo[buf].buflisted then
            listed[#listed + 1] = buf
          end
        end
        if #listed == 1 then
          local buf = listed[1]
          return vim.api.nvim_buf_get_name(buf) == "" and not vim.bo[buf].modified
        end
        return false
      end)()

      local function open_and_replace_window()
        local orig_win = vim.api.nvim_get_current_win()
        local orig_buf = vim.api.nvim_get_current_buf()
        vim.cmd("CodeCompanionChat Toggle")
        vim.schedule(function()
          if vim.api.nvim_win_is_valid(orig_win) and vim.api.nvim_get_current_win() ~= orig_win then
            vim.api.nvim_win_close(orig_win, false)
          end
          if vim.api.nvim_buf_is_valid(orig_buf) and vim.api.nvim_buf_get_name(orig_buf) == "" and not vim.bo[orig_buf].modified then
            vim.api.nvim_buf_delete(orig_buf, { force = false })
          end
        end)
      end

      if only_empty_buffer then
        open_and_replace_window()
      elseif vim.o.columns < 160 then
        -- Small window: open in a new tab, then remove the empty buffer tabnew created
        vim.cmd("tabnew")
        open_and_replace_window()
      else
        vim.cmd("CodeCompanionChat Toggle")
      end
    end

    vim.keymap.set('n', '<leader>a', smart_toggle_ai_chat, { desc = "Toggle AI chat buffer" })
  end
}
