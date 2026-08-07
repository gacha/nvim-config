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
    code_companion.adapter_type = ""
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
        pattern = { "CodeCompanionChat*", "CodeCompanionACPSession*" },
        group = group,
        callback = function(request)
          -- vim.notify("CC event.match: " .. vim.inspect(request), vim.log.levels.INFO)
          if vim.tbl_contains({"CodeCompanionChatOpened", "CodeCompanionChatSubmitted", "CodeCompanionChatCompacting"}, request.match) then
            if request.match ~= "CodeCompanionChatOpened" then
              self.processing = true
            elseif self.adapter_type == "acp" then
              self.processing = true
            end
          elseif vim.tbl_contains({"CodeCompanionACPSessionPost", "CodeCompanionChatDone", "CodeCompanionChatStopped", "CodeCompanionChatCleared"}, request.match) then
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

          local adapter = event.data.adapter
          if adapter then
            self.adapter_type = adapter.type or self.adapter_type
            self.adapter_name = adapter.formatted_name or adapter.name or self.adapter_name
            self.model_name = (adapter.model and adapter.model.name) or event.data.model or self.model_name
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
