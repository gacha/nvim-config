-- Methods to show CodeCompanion loading
local function is_codecompanion_chat_buffer(bufnr)
  bufnr = bufnr or vim.api.nvim_get_current_buf()
  if not vim.api.nvim_buf_is_valid(bufnr) then
    return false
  end

  -- Option 1: Check by filetype (REPLACE 'codecompanion_ft' with the actual filetype)
  local ft = vim.api.nvim_get_option_value("filetype", { buf = bufnr })
  if ft == "codecompanion" then
    return true
  end

  return false
end

local function codecompanion_modifiable_status()
  local current_bufnr = vim.api.nvim_get_current_buf()
  if is_codecompanion_chat_buffer(current_bufnr) then
    if not vim.api.nvim_get_option_value("modifiable", { buf = current_bufnr }) then
      return "✨ AI is thinking..."
    else
      return ""
    end
  end
  return ""
end
-- end of CodeCompanion methods

return {
  'nvim-lualine/lualine.nvim',
  dependencies = {'nvim-tree/nvim-web-devicons'},
  config = function()
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
          codecompanion_modifiable_status,
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
    }
  end,
}
