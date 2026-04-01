return {
  'nvim-lualine/lualine.nvim',
  dependencies = {
    'nvim-tree/nvim-web-devicons',
    'franco-ruggeri/codecompanion-lualine.nvim',
    },
  config = function()
    function hide_from_code_companion()
      local buf_id = vim.api.nvim_get_current_buf()
      local buf_file_type = vim.api.nvim_buf_get_option(buf_id, 'filetype')
      return buf_file_type ~= 'codecompanion'
    end

    function show_encoding_if_not_utf8()
      local buf_id = vim.api.nvim_get_current_buf()
      local encoding = vim.bo[buf_id].fileencoding
      return encoding ~= 'utf-8' and encoding ~= ''
    end

    function show_fileformat_if_not_unix()
      local buf_id = vim.api.nvim_get_current_buf()
      local fileformat = vim.bo[buf_id].fileformat
      return fileformat ~= 'unix'
    end

    require('lualine').setup {
      options = { theme  = 'gruvbox' },
      sections = {
        lualine_a = {},
        lualine_b = {'branch', 'diff', 'diagnostics'},
        lualine_c = {
          {
            'filename',
            path = 1
          },
        },
        lualine_x = {
          'codecompanion',
          {
            'encoding',
            cond = show_encoding_if_not_utf8,
          },
          {
            'fileformat',
            cond = function()
              return show_fileformat_if_not_unix() and hide_from_code_companion()
            end,
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
