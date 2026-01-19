return {
  'nvim-lualine/lualine.nvim',
  dependencies = {'nvim-tree/nvim-web-devicons'},
  config = function()
    --CodeCompanion methods to show CodeCompanion loading
    local code_companion = require("lualine.component"):extend()

    code_companion.processing = false
    code_companion.model_name = "🤖 [Unknown]"
    code_companion.spinner_index = 1

    local spinner_symbols = {
      "⣾",
      "⣽",
      "⣻",
      "⢿",
      "⡿",
      "⣟",
      "⣯",
      "⣷"
    }

    -- Initializer
    function code_companion:init(options)
      code_companion.super.init(self, options)

      local group = vim.api.nvim_create_augroup("CodeCompanionHooks", {})

      -- Request hook
      vim.api.nvim_create_autocmd({ "User" }, {
        pattern = "CodeCompanionRequest*",
        group = group,
        callback = function(request)
          if request.match == "CodeCompanionRequestStarted" then
            self.processing = true
          elseif request.match == "CodeCompanionRequestFinished" then
            self.processing = false
          end
        end,
      })

      -- AI model change hook
      vim.api.nvim_create_autocmd({ "User" }, {
        pattern = "CodeCompanionChatModel",
        group = group,
        callback = function(event)
          self.model_name = "🤖 [" .. event.data.model .. "]"
        end,
      })
    end

    -- Function that runs every time statusline is updated
    function code_companion:update_status()
      local bufnr = vim.api.nvim_get_current_buf()
      local filetype = vim.bo[bufnr].filetype

      if self.processing then
        self.spinner_index = (self.spinner_index % #spinner_symbols) + 1
        return spinner_symbols[self.spinner_index] .. " " .. self.model_name
      else
        if filetype == "codecompanion" then
          return self.model_name
        else
          return nil
        end
      end
    end
    -- end of CodeCompanion methods

    require('lualine').setup {
      options = { theme  = 'gruvbox' },
      sections = {
        lualine_a = {},
        lualine_b = {'branch', 'diff', 'diagnostics'},
        lualine_c = {
          {
            'filename',
            path = 1,
          },
          code_companion,
        },
      },
      inactive_sections = {
        lualine_c = {
          {
            'filename',
            path = 1,
          },
        }
      },
      extensions = {'quickfix', 'fzf', 'fugitive', 'lazy', 'oil'}
    }
  end,
}
