return {
  'xolox/vim-notes',
  dependencies = {'xolox/vim-misc'},
  config = function()
    local notes_home = vim.fn.expand('$HOME/Syncthing/default/Notes')
    vim.g.notes_directories = {notes_home}
    vim.g.notes_tab_indents = 0
    vim.g.notes_word_boundaries = 1
  end
}
