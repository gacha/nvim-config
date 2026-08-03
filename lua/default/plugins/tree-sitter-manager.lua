return {
  "romus204/tree-sitter-manager.nvim",
  dependencies = {}, -- tree-sitter CLI must be installed system-wide
  config = function()
    require("tree-sitter-manager").setup({
      ensure_installed = { 'html', 'ruby', 'javascript', 'go', 'c', 'lua', 'vim', 'vimdoc', 'bash', 'yaml', 'diff' },
    })
  end,
}
