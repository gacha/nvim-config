return {
  'nvim-lualine/lualine.nvim',
  dependencies = {
    'nvim-tree/nvim-web-devicons',
  },
  config = function()
    -- CodeCompanion statusline component
    -- Reads adapter/model from CodeCompanion's own per-buffer metadata,
    -- tracks processing state per-buffer so switching chats shows correct info.
    local code_companion = require("lualine.component"):extend()

    local spinner_symbols = { "⣾", "⣽", "⣻", "⢿", "⡿", "⣟", "⣯", "⣷" }
    local buf_processing = {}
    local spinner_index = 0

    function code_companion:init(options)
      code_companion.super.init(self, options)

      local group = vim.api.nvim_create_augroup("CodeCompanionHooks", { clear = true })

      local busy_events = {
        CodeCompanionChatSubmitted = true,
        CodeCompanionChatCompacting = true,
        CodeCompanionRequestStarted = true,
      }
      local idle_events = {
        CodeCompanionRequestFinished = true,
        CodeCompanionChatDone = true,
        CodeCompanionChatStopped = true,
        CodeCompanionChatCleared = true,
      }

      vim.api.nvim_create_autocmd("User", {
        pattern = "CodeCompanion*",
        group = group,
        callback = function(event)
          local bufnr = event.data and event.data.bufnr
          if not bufnr then return end

          if busy_events[event.match] then
            buf_processing[bufnr] = true
          elseif idle_events[event.match] then
            buf_processing[bufnr] = nil
          elseif event.match == "CodeCompanionChatClosed" then
            buf_processing[bufnr] = nil
          end
        end,
      })
    end

    function code_companion:update_status()
      local bufnr = vim.api.nvim_get_current_buf()
      if vim.bo[bufnr].filetype ~= "codecompanion" then
        return nil
      end

      local status = "🤖 "
      if buf_processing[bufnr] then
        spinner_index = (spinner_index % #spinner_symbols) + 1
        status = spinner_symbols[spinner_index] .. " " .. status
      end

      local meta = _G.codecompanion_chat_metadata and _G.codecompanion_chat_metadata[bufnr]
      if meta and meta.adapter then
        local name = meta.adapter.name or ""
        local model = meta.adapter.model or ""
        if model ~= "" then
          return status .. name .. " → " .. model
        elseif name ~= "" then
          return status .. name
        end
      end

      return status
    end

    local function hide_from_code_companion()
      return vim.bo[vim.api.nvim_get_current_buf()].filetype ~= "codecompanion"
    end

    require('lualine').setup {
      options = { theme = 'gruvbox' },
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
