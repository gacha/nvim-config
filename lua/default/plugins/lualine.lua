return {
  'nvim-lualine/lualine.nvim',
  dependencies = {'nvim-tree/nvim-web-devicons'},
  config = function()
    --CodeCompanion methods to show CodeCompanion loading
    local code_companion = require("lualine.component"):extend()

    code_companion.processing = false
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
    end

    -- Function that runs every time statusline is updated
    function code_companion:update_status()
      if self.processing then
        self.spinner_index = (self.spinner_index % #spinner_symbols) + 1
        return "✨ " .. spinner_symbols[self.spinner_index]
      else
        return nil
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
