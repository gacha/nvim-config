return {
  'hrsh7th/nvim-cmp',
  dependencies = {
    'hrsh7th/cmp-buffer',
    'hrsh7th/cmp-nvim-lsp',
    'petertriho/cmp-git',
    'hrsh7th/cmp-path',
    'onsails/lspkind.nvim',
    {
      'L3MON4D3/LuaSnip',
      dependencies = {'rafamadriz/friendly-snippets', 'saadparwaiz1/cmp_luasnip'},
      -- follow latest release.
      version = '1.*',
      -- install jsregexp (optional!).
      build = 'make install_jsregexp',
      config = function()
        require('luasnip.loaders.from_snipmate').lazy_load()
        require("luasnip.loaders.from_vscode").lazy_load()
        local ls = require('luasnip')
        ls.filetype_extend("ruby", {"rails"})
        vim.keymap.set({'i'}, '<C-K>', function() ls.expand() end, {silent = true})
        vim.keymap.set({'i', 's'}, '<C-L>', function() ls.jump( 1) end, {silent = true})
        vim.keymap.set({'i', 's'}, '<C-J>', function() ls.jump(-1) end, {silent = true})
        vim.keymap.set({'i', 's'}, '<C-E>', function()
          if ls.choice_active() then
            ls.change_choice(1)
          end
        end, {silent = true})
      end
    }
  },
  config = function()
    local has_words_before = function()
      unpack = unpack or table.unpack
      local line, col = unpack(vim.api.nvim_win_get_cursor(0))
      return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
    end
    local cmp = require('cmp')
    local luasnip = require('luasnip')
    local lspkind = require('lspkind')
    cmp.setup({
      preselect = 'none',
      performance = {
        max_view_entries = 10,
      },
      view = {
        -- docs = {auto_open = false},
        entries = {name = 'custom', selection_order = 'near_cursor'}
      },
      completion = {
        completeopt = 'noinsert,menuone,noselect',
      },
      sources = {
        { name = 'nvim_lsp', keyword_length = 3 },
        {
          name = 'buffer',
          keyword_length = 3,
          option = {
            get_bufnrs = function()
              local bufs = {}
              for _, win in ipairs(vim.api.nvim_list_wins()) do
                local buf = vim.api.nvim_win_get_buf(win)
                local byte_size = vim.api.nvim_buf_get_offset(buf, vim.api.nvim_buf_line_count(buf))
                if byte_size < 1024 * 1024 then -- 1 Megabyte max
                  bufs[buf] = true
                end
              end
              return vim.tbl_keys(bufs)
            end,
          },
        },
        -- { name = 'cmp_tabnine', keyword_length = 3 },
        { name = 'luasnip', keyword_length = 3 },
        { name = 'path' },
      },
      mapping = {
        ['<CR>'] = cmp.mapping.confirm({
          select = false,
        }),
        ['<Tab>'] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_next_item({ select = true })
          elseif luasnip.expand_or_jumpable() then
            luasnip.expand_or_jump()
          elseif has_words_before() then
            cmp.complete()
          else
            fallback()
          end
        end, { 'i', 's' }),
        ['<S-Tab>'] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_prev_item()
          elseif luasnip.jumpable(-1) then
            luasnip.jump(-1)
          else
            fallback()
          end
        end, { 'i', 's' }),
        ['<C-g>'] = function()
          if cmp.visible_docs() then
            cmp.close_docs()
          else
            cmp.open_docs()
          end
        end,
        ['<C-k>'] = cmp.mapping.scroll_docs(-4),
        ['<C-j>'] = cmp.mapping.scroll_docs(4),
      },
      snippet = {
        expand = function(args)
          if not luasnip then
            return
          end
          luasnip.lsp_expand(args.body)
        end,
      },
      window = {
        -- completion = cmp.config.window.bordered(),
        documentation = cmp.config.window.bordered({
          border = "rounded",
          winhighlight = "Normal:PMenu,FloatBorder:PMenu"
        }),
      },
      formatting = {
        format = lspkind.cmp_format({
          mode = 'symbol', -- show only symbol annotations
          maxwidth = 50, -- prevent the popup from showing more than provided characters (e.g 50 will not show more than 50 characters)
          ellipsis_char = '...', -- when popup menu exceed max-width, the truncated part would show ellipsis_char instead (must define max-width first)
          symbol_map = {
            TabNine = "",
          },
        })
      },
    })
    -- Set configuration for specific file types.
    cmp.setup.filetype('gitcommit', {
      sources = cmp.config.sources({
        { name = 'git' },
      }, {
          { name = 'buffer' },
        })
    })
    cmp.setup.filetype('notes', {
      sources = cmp.config.sources({
        { name = 'buffer' },
      })
    })
    cmp.setup.filetype('log', {
      sources = cmp.config.sources({}),
      completion = {
        autocomplete = false
      }
    })
  end,
}
