let os = substitute(system('uname'), "\n", "", "")

call plug#begin('~/.vim/plugged')

Plug 'mileszs/ack.vim'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'tacahiroy/ctrlp-funky'
Plug 'morhetz/gruvbox'
" Plug 'vim-scripts/wombat256.vim'
" Plug 'altercation/vim-colors-solarized'
Plug 'kassio/neoterm'
Plug 'benekastah/neomake'
Plug 'Shougo/deoplete.nvim'
Plug 'plasticboy/vim-markdown', { 'for': 'markdown' }
Plug 'bling/vim-airline'
Plug 'vim-ruby/vim-ruby', { 'for': 'ruby' }
Plug 'tpope/vim-rake', { 'for': 'ruby' }
Plug 'tpope/vim-rails', { 'for': 'ruby' }
Plug 'tpope/vim-rbenv', { 'for': 'ruby' }
Plug 'tpope/vim-bundler', { 'for': 'ruby' }
Plug 'Keithbsmiley/rspec.vim', { 'for': 'ruby' }
Plug 'thoughtbot/vim-rspec', { 'for': 'ruby' }
Plug 'fishbullet/deoplete-ruby', { 'for': 'ruby' }
Plug 'tpope/vim-vinegar'
Plug 'tpope/vim-endwise'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-abolish'
Plug 'tpope/vim-fugitive'
Plug 'int3/vim-extradite'
Plug 'tpope/vim-haml'
Plug 'tomtom/tcomment_vim'
Plug 'nelstrom/vim-textobj-rubyblock'
  Plug 'kana/vim-textobj-user'
Plug 'thinca/vim-localrc'
Plug 'jgdavey/vim-blockle'
Plug 'Shougo/neosnippet.vim'
Plug 'Shougo/neosnippet-snippets'
Plug 'othree/eregex.vim'
Plug 'wakatime/vim-wakatime'
Plug 'othree/html5.vim'
Plug 'xolox/vim-misc'
Plug 'xolox/vim-notes'
Plug 'Shougo/neco-syntax'
Plug 'easymotion/vim-easymotion'
Plug 'junegunn/vim-easy-align'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'mustache/vim-mustache-handlebars'
Plug 'othree/javascript-libraries-syntax.vim', { 'for': 'javascript' }
Plug 'mxw/vim-jsx', { 'for': 'javascript' }
Plug 'ap/vim-css-color'
Plug 'editorconfig/editorconfig-vim'

" Other languages
Plug 'myint/clang-complete', { 'for': ['c', 'cpp'] }
" Plug 'rhysd/vim-crystal', { 'for': 'crystal' }
" Plug 'zchee/deoplete-go', { 'for': 'go', 'do': 'make'}
" Plug 'vim-scripts/groovy.vim', { 'for': 'groovy' }
" Plug 'elixir-lang/vim-elixir', { 'for': 'elixir' }

call plug#end()

" true colors
set termguicolors

"-----------------------
"""""""""""""""""""""""""
" KEYBINDINGS
"""""""""""""""""""""""""
let mapleader=","
inoremap jj <ESC>
map <Leader>r "hy:%S/<C-r>h//gc<left><left><left>
map <Leader>rr :!ruby %<CR>
map <Leader>w :w<CR>
map <Leader>qa :wqa<CR>
map <Leader>[ :bprevious<CR>
map <Leader>] :bnext<CR>
map <Leader>p "+p<CR>
map <Leader>y "+y<CR>
map <Leader>D "_dd<CR>
map <Leader>d "_d<CR>
map // :TComment<CR>
map <Leader>r8 :vertical resize 80<CR>
map <Leader>r12 :vertical resize 120<CR>
map <F5> :so $MYVIMRC<CR>
nnoremap <leader>. :CtrlPTag <CR>
nnoremap <Leader>fu :CtrlPFunky<Cr>
" narrow the list down with a word under cursor
nnoremap <Leader>fU :execute 'CtrlPFunky ' . expand('<cword>')<Cr>

" run set test lib
nnoremap <Leader>A :call neoterm#test#run('all')<cr>
nnoremap <Leader>T :call neoterm#test#run('file')<cr>
nnoremap <Leader>R :call neoterm#test#run('current')<cr>
nnoremap <Leader>L :call neoterm#test#rerun()<cr>

" Useful maps
" closes the all terminal buffers
nnoremap <Leader>tc :call neoterm#close_all()<cr>
" clear terminal
nnoremap <Leader>tl :call neoterm#clear()<cr>

" clear highlight
map <Leader><Leader>h :set hlsearch!<CR>

" regenerate CTAGS with ripper-tags and coffeetags
map <Leader>ct :silent !~/.rbenv/shims/ripper-tags -R --exclude=vendor && ~/.rbenv/shims/coffeetags -R -a -f tags<CR>

" Devdocs docs
command! -nargs=? DevDocs :call system('type -p open >/dev/null 2>&1 && open http://devdocs.io/#q=<args> || xdg-open http://devdocs.io/#q=<args>')
au FileType python,ruby,rspec,javascript,html,php,eruby,coffee,haml nmap <buffer> K :exec "DevDocs " . fnameescape(expand('<cword>'))<CR>

" Edit another file in the same directory as the current file
" uses expression to extract path from current file's path
map <Leader>e :e <C-R>=escape(expand("%:p:h"),' ') . '/'<CR>
map <Leader>s :split <C-R>=escape(expand("%:p:h"), ' ') . '/'<CR>
map <Leader>v :vnew <C-R>=escape(expand("%:p:h"), ' ') . '/'<CR>

" EasyMotion
nmap s <Plug>(easymotion-s2)
nmap t <Plug>(easymotion-t2)
map <Leader>l <Plug>(easymotion-lineforward)
map <Leader>j <Plug>(easymotion-j)
map <Leader>k <Plug>(easymotion-k)
map <Leader>h <Plug>(easymotion-linebackward)

" Rubocop fix current file
nmap <leader>rc :call RubocopAutoFix()<CR>

" Easy align
" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)
" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)

command! Q q " Bind :Q to :q
command! Qall qall
command! W w
nnoremap <C-t> :FZF<cr>
let g:ctrlp_map = '<c-e>'
nmap <F7> :setlocal spell! spell?<CR>
" Toggle relative numbers
map <Leader>n :call NumberToggle()<CR>
" Toggle dark/ligh colortheme
map <Leader>c :call ColorToggle()<CR>

" Open Neomake warning/error split
nnoremap <Leader><Leader>l :lopen<CR>tocmd! BufWritePost * Neomake

" Neosnippet Plugin's key-mappings.
imap <C-k>     <Plug>(neosnippet_expand_or_jump)
smap <C-k>     <Plug>(neosnippet_expand_or_jump)
xmap <C-k>     <Plug>(neosnippet_expand_target)


" Silversearcher
let g:fzf_command_prefix = 'Ack'
let g:ackprg = 'ag --vimgrep --smart-case'
cnoreabbrev ag Ack
cnoreabbrev aG Ack
cnoreabbrev Ag Ack
cnoreabbrev AG Ack

" some built in keybindings for included plugins
"
" matchit - <%> jums to other end of selected brackets
" surround - <cs'"> - change ' to " around current selection
" surround - <ds"> - remove " around current selection
" surround - <yss[> - surounds current selection with [
" textobj-rubyblock - var - selects outer ruby block
"                     vir - selects inner ruby block
"""""""""""""""""""""""""
" Basic features
"""""""""""""""""""""""""

" Misc
set lazyredraw
set splitbelow
set splitright
set complete+=kspell
set diffopt+=vertical
set shell=/bin/zsh
scriptencoding utf-8
set encoding=utf-8
set termencoding=utf-8
set clipboard+=unnamed
filetype plugin indent on " Do filetype detection and load custom file plugins and indent files
set laststatus=2          " When you go into insert mode,
                          " the status line color changes.
                          " When you leave insert mode,
                          " the status line color changes back.

" Display options
syntax on
set pastetoggle=<F12>
set cursorline
set number
set list!                       " Display unprintable characters
set listchars=tab:▸\ ,trail:•,extends:»,precedes:«
colorscheme gruvbox
let g:gruvbox_contrast_dark = "hard" " soft, medium, hard
set background=dark
set t_ut= " fixes transparent BG on tmux

" Always edit file, even when swap file is found
set shortmess+=A
set hidden                         " Don't abandon buffers moved to the background
set wildmenu                       " Enhanced completion hints in command line
set backspace=eol,start,indent     " Allow backspacing over indent, eol, & start
set complete=.,w,b,u,U,t,i,d       " Do lots of scanning on tab completion
set directory=~/.config/nvim/swap  " Directory to use for the swap file
set diffopt=filler,iwhite          " In diff mode, ignore whitespace changes and align unchanged lines
set nowrap
set visualbell
set mouse=a

" Relative line numbers
set relativenumber
autocmd InsertLeave * :call NumberToggle()
autocmd InsertEnter * :call NumberToggle()

" Indentation and tabbing
set autoindent smartindent
set smarttab                    " Make <tab> and <backspace> smarter
set tabstop=2
set expandtab
set shiftround
set shiftwidth=2
set incsearch
" viminfo: remember certain things when we exit
" (http://vimdoc.sourceforge.net/htmldoc/usr_21.html)
"   %    : saves and restores the buffer list
"   '100 : marks will be remembered for up to 30 previously edited files
"   /100 : save 100 lines from search history
"   h    : disable hlsearch on start
"   "500 : save up to 500 lines for each register
"   :100 : up to 100 lines of command-line history will be remembered
"   n... : where to save the viminfo files
set viminfo=%100,'100,/100,h,\"500,:100,n~/.config/nvim/viminfo

" Autosave
autocmd CursorHold,CursorHoldI,InsertLeave * silent! wall

" Undo
set undolevels=1000                     " How many undos
set undoreload=10000                    " number of lines to save for undo
if has("persistent_undo")
  set undodir=~/.config/nvim/undo       " Allow undoes to persist even after a file is closed
  set undofile
endif

" Search settings
set ignorecase
set smartcase
set hlsearch
set incsearch
set showmatch

" to_html settings
let html_number_lines = 1
let html_ignore_folding = 1
let html_use_css = 1
"let html_no_pre = 0
let use_xhtml = 1
let xml_use_xhtml = 1

" Show a vertical line/guard at column 80
let &colorcolumn=join(range(81,999),",")
highlight ColorColumn ctermbg=235 guibg=#2c2d27
let &colorcolumn="80,".join(range(120,999),",")

"""""""""""""""""""""""""
" Plugin's
"""""""""""""""""""""""""
" Use deoplete.
let g:deoplete#enable_at_startup = 1
let g:monster#completion#rcodetools#backend = "async_rct_complete"
let g:deoplete#sources#omni#input_patterns = {
\   "ruby" : '[^. *\t]\.\w*\|\h\w*::'
\}

" For clang with 
let g:clang_complete_auto = 0
let g:clang_auto_select = 0
let g:clang_omnicppcomplete_compliance = 0
let g:clang_make_default_keymappings = 0
let g:clang_library_path = '/usr/lib/llvm-3.5/lib'

" Notes
let g:notes_directories = ['~/Dropbox/Notes']
let g:notes_tab_indents = 0
let g:notes_word_boundaries = 1


let g:rspec_command = "!if [ -f ./bin/rspec ]; then; ./bin/rspec {spec}; else; bundle exec rspec {spec}; fi;"

" Ctrl-P
let g:ctrlp_working_path_mode = 'rw'
let g:ctrlp_cmd = 'CtrlPMRU'
if executable('ag')
  let g:ctrlp_user_command = 'ag %s -i --nocolor --nogroup --hidden
      \ --ignore .git
      \ --ignore .svn
      \ --ignore .hg
      \ --ignore .DS_Store
      \ -g ""'
  if os == "Darwin"
    let g:ctrlp_use_caching = 0
  endif
else
  let g:ctrlp_custom_ignore = '\v[\/]\.(git|hg|svn|log)$'
  let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files . --cached --exclude-standard --others']
endif

" Don't jump to already open window. This is annoying if you are maintaining
" several Tab workspaces and want to open two windows into the same file.
let g:ctrlp_switch_buffer = 1

" Funky
let g:ctrlp_funky_ruby_classes = 1
let g:ctrlp_funky_ruby_modules = 1

" Airline
let g:airline#extensions#tabline#enabled = 1
let g:airline_powerline_fonts = 1
let g:tmuxline_powerline_separators = 0
let g:airline_left_sep = ''
let g:airline_right_sep = ''
let g:airline_section_z = "%{neoterm#test#status('running')}%{neoterm#test#status('success')}%{neoterm#test#status('failed')}"


" Neomake
let g:neomake_ruby_reek_maker_errorformat =
        \ '%E%.%#: Racc::ParseError: %f:%l :: %m,' .
        \ '%W%f:%l: %m'
let g:neomake_ruby_reek_maker = {
    \ 'args': ['--single-line'],
    \ 'errorformat': g:neomake_ruby_reek_maker_errorformat,
    \ }
let g:neomake_ruby_reek_exe = $HOME . '/.rbenv/shims/reek'
let g:neomake_ruby_rubocop_exe = $HOME . '/.rbenv/shims/rubocop'

let g:neomake_ruby_enabled_makers = ['mri', 'rubocop', 'reek']
let g:neomake_serialize = 1
let g:neomake_serialize_abort_on_error = 1
" Run NeoMake on read and write operations
autocmd! BufReadPost,BufWritePost * Neomake

let g:ctrlp_custom_ignore = '/\.\|\.o\|\.so|\.log'

" Neoterm
let g:neoterm_clear_cmd = "clear; printf '=%.0s' {1..80}; clear"
let g:neoterm_run_tests_bg = 1
let g:neoterm_raise_when_tests_fail = 1
let g:neoterm_size = 10

let g:neoterm_rspec_lib_cmd = 'bundle exec ./bin/rspec'

" JS libs
let g:used_javascript_libs = 'jquery,handlebars,underscore'

" ignores for ctrlp
set wildignore+=tags
set wildignore+=*/tmp/*
set wildignore+=*/spec/vcr/*
set wildignore+=*/public/*
set wildignore+=*/coverage/*
set wildignore+=*.png,*.jpg,*.otf,*.woff,*.jpeg,*.orig

" Markdown
let g:vim_markdown_folding_disabled=1

" Snippets

" Tell Neosnippet about the other snippets
let g:neosnippet#snippets_directory='~/.config/nvim/neosnippets'

" SuperTab like snippets behavior.
imap <expr><TAB> neosnippet#expandable_or_jumpable() ?
\ "\<Plug>(neosnippet_expand_or_jump)"
\: pumvisible() ? "\<C-n>" : "\<TAB>"
smap <expr><TAB> neosnippet#expandable_or_jumpable() ?
\ "\<Plug>(neosnippet_expand_or_jump)"
\: "\<TAB>"

" For snippet_complete marker.
if has('conceal')
  set conceallevel=2 concealcursor=i
endif

" EasyMotion
" Use uppercase target labels and type as a lower case
let g:EasyMotion_use_upper = 1
" type `l` and match `l`&`L`
let g:EasyMotion_smartcase = 1
" Smartsign (type `3` and match `3`&`#`)
let g:EasyMotion_use_smartsign_us = 1

" Tags
set tags+=,ruby.tags
set tags+=,coffee.tags

" ruby
autocmd FileType ruby,eruby,yaml,haml setlocal iskeyword+=?
autocmd FileType ruby,eruby,yaml,haml setlocal iskeyword+=!

" omnifuncs
set omnifunc=syntaxcomplete#Complete
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags
autocmd FileType ruby setlocal omnifunc=rubycomplete#Complete

" Markdown
autocmd BufRead,BufNewFile *.md setlocal textwidth=80

" Handlebars/Mustache
autocmd BufRead,BufNewFile *.hb.erb set filetype=mustache

"""""""""""""""""""""""""
" Custom functions
"""""""""""""""""""""""""

"Toggle arrow keys

function! RubocopAutoFix()
  exe "w"
  silent exe "!~/.rbenv/shims/rubocop -a -R % &> /dev/null"
  silent exe "e %"
  silent exe "Neomake"
endfun

"This allows for change paste motion cp{motion}
nmap <silent> cp :set opfunc=ChangePaste<CR>g@
function! ChangePaste(type, ...)
    silent exe "normal! `[v`]\"_c"
    silent exe "normal! p"
endfunction

" When opening a file, always jump to the last cursor position
autocmd BufReadPost *
    \ if line("'\"") > 0 && line ("'\"") <= line("$") |
    \     exe "normal g'\"" |
    \ endif |

function! NumberToggle()
  if(&relativenumber == 1)
    set norelativenumber
    set number
  else
    set relativenumber
  endif
endfunc

function! ColorToggle()
  if(&background == "dark")
    set background=light
  else
    set background=dark
  endif
endfunction
