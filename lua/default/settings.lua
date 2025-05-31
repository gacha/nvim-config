vim.opt.number = true
vim.opt.mouse = 'a'
vim.opt.smartcase = true
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.wrap = false
vim.opt.autoindent = true
vim.opt.smartindent = true
vim.opt.expandtab = true
vim.opt.tabstop = 2
vim.opt.shiftround = true
vim.opt.ignorecase = true
vim.opt.shiftwidth = 2
vim.opt.listchars = {tab = '▸ ',trail = '•',extends = '»',precedes = '«'}
vim.opt.list = true -- enable the stuff above
vim.opt.signcolumn = 'yes'
vim.opt.exrc = true
vim.opt.spelllang = 'en_us'
vim.opt.spell = false -- enable later for specific file types
vim.opt.spellsuggest = 'best,10'
vim.opt.termguicolors = true

-- Undo
if vim.fn.has('persistent_undo') == 1 then
  vim.opt.undodir = vim.fn.expand('$HOME/.config/nvim/undo')
  vim.opt.undofile = true
end

-- Crontab
if vim.env.VIM_CRONTAB == "true" then
  vim.opt.backup = false
  vim.opt.writebackup = false
end

-- Diagnostics
local signs = { Error = "󰅚", Warn = "󰀪", Hint = "", Info = " " }
vim.diagnostic.config {
  virtual_text = {
    severity = vim.diagnostic.severity.ERROR,
  },
  virtual_lines = false,
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = signs.Error,
      [vim.diagnostic.severity.WARN] = signs.Warn,
      [vim.diagnostic.severity.HINT] = signs.Hint,
      [vim.diagnostic.severity.INFO] = signs.Info,
    },
    linehl = {
      [vim.diagnostic.severity.ERROR] = "Error",
      [vim.diagnostic.severity.WARN] = "Warn",
      [vim.diagnostic.severity.HINT] = "Hint",
      [vim.diagnostic.severity.INFO] = "Info",
    },
    active = {
      { name = "DiagnosticSignError", text = signs.Error },
      { name = "DiagnosticSignWarn",  text = signs.Warn },
      { name = "DiagnosticSignHint",  text = signs.Hint },
      { name = "DiagnosticSignInfo",  text = signs.Info },
    },
  },
  update_in_insert = false,
  underline = false,
  severity_sort = true,
  float = {
    focusable = false,
    style = "minimal",
    border = "rounded",
    source = "if_many",
    header = "",
    prefix = "",
    suffix  = "",
    format = function(diagnostic)
      -- remove unwanted text from rubocop
      return string.gsub(diagnostic.message, "This offense is not autocorrectable.", "")
    end
  },
}

-- LSP
vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(
  vim.lsp.handlers.hover, {
    border = "rounded"
  }
)

vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(
  vim.lsp.handlers.signature_help, {
    border = "rounded"
  }
)

--
-- AutoCommands
--

-- Go to the last location
vim.api.nvim_create_autocmd('BufReadPost', {
  callback = function()
    local mark = vim.api.nvim_buf_get_mark(0, '"')
    local lcount = vim.api.nvim_buf_line_count(0)
    if mark[1] > 0 and mark[1] <= lcount then
      vim.cmd("norm! g'\"")
    end
  end,
})

-- Enable spell
vim.api.nvim_create_autocmd(
  { "BufRead", "BufNewFile", "FileType" },
  { pattern = { "*.txt", "*.md", "notes", "gitcommit" }, command = "setlocal spell" }
)
