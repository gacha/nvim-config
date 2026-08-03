return {
  'nvim-lualine/lualine.nvim',
  dependencies = {
    'nvim-tree/nvim-web-devicons',
    'franco-ruggeri/codecompanion-lualine.nvim',
    },
  config = function()
    --CodeCompanion methods to show CodeCompanion loading
    local code_companion = require("lualine.component"):extend()

    code_companion.processing = false
    code_companion.ai_name = "🤖 [Unknown]"
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
      vim.api.nvim_create_autocmd("User", {
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

      -- AI adapter/model change hook
      vim.api.nvim_create_autocmd("User", {
        pattern = { "CodeCompanionChatAdapter", "CodeCompanionChatModel" },
        group = group,
        callback = function(event)
          -- vim.notify("CC event.match: " .. event.match, vim.log.levels.INFO)
          -- vim.notify("CC event.data: " .. vim.inspect(event.data), vim.log.levels.INFO)
          local agent_name, model_name

          if event.data.adapter then
            if event.data.adapter.formatted_name then
              agent_name = event.data.adapter.formatted_name
            elseif event.data.adapter.name then
              agent_name = event.data.adapter.name
            end
            if event.data.adapter.model and event.data.adapter.model.name then
              model_name = event.data.adapter.model.name
            end
          end

          if agent_name then
            if model_name then
              self.ai_name = "🤖 " .. agent_name .. "@" .. model_name
            else
              self.ai_name = "🤖 " .. agent_name
            end
          end
        end,
      })
    end

    -- Function that runs every time statusline is updated
    function code_companion:update_status()
      local bufnr = vim.api.nvim_get_current_buf()
      local filetype = vim.bo[bufnr].filetype

      if self.processing then
        self.spinner_index = (self.spinner_index % #spinner_symbols) + 1
        return spinner_symbols[self.spinner_index] .. " " .. self.ai_name
      else
        if filetype == "codecompanion" then
          return self.ai_name
        else
          return nil
        end
      end
    end

    function hide_from_code_companion()
      local buf_id = vim.api.nvim_get_current_buf()
      local buf_file_type = vim.api.nvim_buf_get_option(buf_id, 'filetype')
      return buf_file_type ~= 'codecompanion'
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
            cond = hide_from_code_companion,
          },
          code_companion,
        },
        lualine_x = {
          'encoding',
          {
            'fileformat',
            cond = hide_from_code_companion,
          },
          {
            'filetype',
            cond = hide_from_code_companion,
          },
        },
      },
      inactive_sections = {
        lualine_c = {
          {
            'filename',
            path = 0,
          },
        }
      },
      extensions = {'quickfix', 'fzf', 'fugitive', 'lazy', 'oil'}
    }
  end,
}
