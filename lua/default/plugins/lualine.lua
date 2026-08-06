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
    code_companion.adapter_name = nil
    code_companion.model_name = nil
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
        pattern = { "CodeCompanionChat*", "CodeCompanionACPSession*", "CodeCompanionMCPServer*" },
        group = group,
        callback = function(request)
          -- vim.notify("CC event.match: " .. request.match, vim.log.levels.INFO)
          if vim.tbl_contains({"CodeCompanionChatCreated", "CodeCompanionACPSessionPre", "CodeCompanionMCPServerStart", "CodeCompanionChatSubmitted", "CodeCompanionChatCompacting"}, request.match) then
            self.processing = true
          elseif vim.tbl_contains({"CodeCompanionACPSessionPost", "CodeCompanionMCPServerReady", "CodeCompanionChatDone", "CodeCompanionChatStopped", "CodeCompanionChatCleared"}, request.match) then
            self.processing = false
          end
        end,
      })

      -- AI adapter/model change hook
      vim.api.nvim_create_autocmd("User", {
        pattern = { "CodeCompanionChatAdapter", "CodeCompanionChatModel", "CodeCompanionACPSessionPost" },
        group = group,
        callback = function(event)
          -- vim.notify("CC event.match: " .. event.match, vim.log.levels.INFO)
          -- vim.notify("CC event.data: " .. vim.inspect(event.data), vim.log.levels.INFO)

          if event.data.adapter then
            if event.data.adapter.formatted_name then
              self.adapter_name = event.data.adapter.formatted_name
            elseif event.data.adapter.name then
              self.adapter_name = event.data.adapter.name
            end
            if event.data.adapter.model and event.data.adapter.model.name then
              self.model_name = event.data.adapter.model.name
            elseif event.data.model then
              self.model_name = event.data.model
            end
          end
        end,
      })
    end

    function code_companion:get_status()
      local status = "🤖 "
      if self.processing then
        self.spinner_index = (self.spinner_index % #spinner_symbols) + 1
        status = spinner_symbols[self.spinner_index] .. " " .. status
      end
      if self.adapter_name then
        if self.model_name then
          return status .. self.adapter_name .. " → " .. self.model_name
        end
        return status .. self.adapter_name
      else
        return status
      end
    end

    -- Function that runs every time statusline is updated
    function code_companion:update_status()
      local bufnr = vim.api.nvim_get_current_buf()
      local filetype = vim.bo[bufnr].filetype

      if filetype == "codecompanion" then
        return self.get_status(self)
      else
        return nil
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
