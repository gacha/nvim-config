About
------------
Neovim config used by me as a ruby developer.

Features
------------

  - LSP enabled
  - autocompletes lsp, buffers, snippets, paths
  - you can undo even after the editor was closed
  - file opens in the same line as was closed
  - inline Rspec execution
  - search content of file using normal (no alien regexp vim syntax) posix REGEXP with `/`
  - fast project/buffer/ navigation with Fzf
  - fast file browsing using Oil, fast access with `-`
  - fast [esc] with `jj`
  - fast jumping in normal mode `s` followed by 2 chars
  - Minimal Gemini AI integration, just provide `GEMINI_API_KEY` ENV variable
  - ...

Installation
------------

Install neovim.
Run `:Lazy` and `I` to install all plugins.
Run `:checkhealth` to see whats missing.

Debug
------------
If something doesn't work try `:messages`.
