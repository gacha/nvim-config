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

    -- Try to seed the adapter/model name from CodeCompanion's config so the
    -- statusline shows something before any CodeCompanion event fires.
    local function default_adapter_info()
      local ok, cc = pcall(require, "codecompanion.config")
      if not ok then
        return nil
      end
      local cfg = cc.config or cc
      local strategies = cfg.strategies or cfg.interactions
      local chat = strategies and strategies.chat
      local adapter = chat and chat.adapter
      if type(adapter) == "table" then
        return adapter.name, adapter.model
      elseif type(adapter) == "string" then
        return adapter, nil
      end
      return nil
    end

    -- Initializer
    function code_companion:init(options)
      code_companion.super.init(self, options)

      local a_name, a_model = default_adapter_info()
      self.adapter_name = self.adapter_name or a_name
      self.model_name = self.model_name or a_model

      local group = vim.api.nvim_create_augroup("CodeCompanionHooks", {})
      local busy_events = {
        CodeCompanionACPSessionPre = true,
        CodeCompanionChatSubmitted = true,
        CodeCompanionChatCompacting = true,
        CodeCompanionRequestStarted = true,
      }
      local idle_events = {
        CodeCompanionACPSessionPost = true,
        CodeCompanionRequestFinished = true,
        CodeCompanionChatDone = true,
        CodeCompanionChatStopped = true,
        CodeCompanionChatCleared = true,
      }

      vim.api.nvim_create_autocmd("User", {
        pattern = "CodeCompanion*",
        group = group,
        callback = function(request)
          if busy_events[request.match] then
            self.processing = true
            if request.match == "CodeCompanionACPSessionPre" then
              self._connect_token = (self._connect_token or 0) + 1
              local token = self._connect_token
              vim.defer_fn(function()
                if self._connect_token == token then
                  self.processing = false
                end
              end, 30000)
            end
          elseif idle_events[request.match] then
            self._connect_token = (self._connect_token or 0) + 1 -- cancel any pending connect timeout
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
