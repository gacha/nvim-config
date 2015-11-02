if has('vim_starting')
   " Required:
   set runtimepath+=~/.config/nvim/bundle/neobundle.vim/
endif
call neobundle#begin(expand('~/.config/nvim/bundle/'))

" Let NeoBundle manage NeoBundle
NeoBundleFetch 'Shougo/neobundle.vim'
NeoBundle 'Shougo/vimproc.vim', {'build': { 'mac' : 'make -f make_mac.mak', 'linux' : 'make' }}

NeoBundle 'smeggingsmegger/ag.vim'
NeoBundle 'kchmck/vim-coffee-script'
NeoBundle 'ctrlpvim/ctrlp.vim'
" themes
NeoBundle 'morhetz/gruvbox'
" NeoBundle 'vim-scripts/wombat256.vim'
" NeoBundle 'altercation/vim-colors-solarized'

NeoBundle 'kris89/vim-multiple-cursors'
NeoBundle 'plasticboy/vim-markdown'
NeoBundle 'bling/vim-airline'
" NeoBundle 'edkolev/tmuxline.vim'
NeoBundle 'vim-ruby/vim-ruby'
" NeoBundle 'tpope/vim-projectionist'
NeoBundle 'tpope/vim-rake'
NeoBundle 'tpope/vim-rails'
NeoBundle 'tpope/vim-vinegar'
NeoBundle 'tpope/vim-endwise'
NeoBundle 'tpope/vim-surround'
NeoBundle 'tpope/vim-repeat'
NeoBundle 'tpope/vim-rbenv'
NeoBundle 'tpope/vim-abolish'
NeoBundle 'tpope/vim-fugitive'
NeoBundle 'int3/vim-extradite'
NeoBundle 'tpope/vim-bundler'
NeoBundle 'Keithbsmiley/rspec.vim'
NeoBundle 'thoughtbot/vim-rspec'
NeoBundle 'tpope/vim-haml'
" NeoBundle 'majutsushi/tagbar'
NeoBundle 'tomtom/tcomment_vim'
NeoBundle 'nelstrom/vim-textobj-rubyblock'
  NeoBundle 'kana/vim-textobj-user'
  NeoBundle 'edsono/vim-matchit'
NeoBundle 'thinca/vim-localrc'
NeoBundle 'alpaca-tc/beautify.vim'
NeoBundle 'jgdavey/vim-blockle'
NeoBundle 'Lokaltog/vim-easymotion'
NeoBundle 'othree/javascript-libraries-syntax.vim'
NeoBundle 'Shougo/neosnippet.vim'
NeoBundle 'Shougo/neosnippet-snippets'
NeoBundle 'othree/eregex.vim'
NeoBundle 'wakatime/vim-wakatime'
" NeoBundle 'elixir-lang/vim-elixir'
NeoBundle 'sjl/gundo.vim'
" NeoBundle 'vhladama/vim-rubyhash'
" NeoBundle 'fatih/vim-go'
" NeoBundle 'vim-scripts/groovy.vim'
NeoBundle 'othree/html5.vim'
NeoBundle 'itchyny/dictionary.vim'
" NeoBundle 'rhysd/vim-crystal'
" NeoBundle 'junegunn/vim-peekaboo'
NeoBundle 'xolox/vim-misc'
NeoBundle 'xolox/vim-notes'
NeoBundle 'mustache/vim-mustache-handlebars'
NeoBundle 'kassio/neoterm'
NeoBundle 'benekastah/neomake'
NeoBundle 'Shougo/deoplete.nvim'
NeoBundle 'Shougo/neco-syntax'

call neobundle#end()
filetype plugin indent on
NeoBundleCheck

" true colors
let $NVIM_TUI_ENABLE_TRUE_COLOR=1

"-----------------------
"""""""""""""""""""""""""
" KEYBINDINGS
"""""""""""""""""""""""""
let mapleader=","
inoremap jj <ESC>
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
let g:neoterm_clear_cmd = "clear; printf '=%.0s' {1..80}; clear"
let g:neoterm_position = 'vertical'
let g:neoterm_automap_keys = ',tt'
" let g:neoterm_rspec_lib_cmd = '!if [ -f ./bin/rspec ]; then; ./bin/rspec {spec}; else; bundle exec rspec {spec}; fi;'
let g:neoterm_rspec_lib_cmd = './bin/rspec'

nnoremap <silent> <f9> :call neoterm#repl#line()<cr>
vnoremap <silent> <f9> :call neoterm#repl#selection()<cr>

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
map <Leader>h :set hlsearch!<CR>

" regenerate CTAGS with ripper-tags
map <Leader>ct :silent !~/.rbenv/versions/2.2.3/bin/ripper-tags -R --exclude=vendor<CR>

" Devdocs docs
command! -nargs=? DevDocs :call system('type -p open >/dev/null 2>&1 && open http://devdocs.io/#q=<args> || xdg-open http://devdocs.io/#q=<args>')
au FileType python,ruby,rspec,javascript,html,php,eruby,coffee,haml nmap <buffer> K :exec "DevDocs " . fnameescape(expand('<cword>'))<CR>

" Edit another file in the same directory as the current file
" uses expression to extract path from current file's path
map <Leader>e :e <C-R>=escape(expand("%:p:h"),' ') . '/'<CR>
map <Leader>s :split <C-R>=escape(expand("%:p:h"), ' ') . '/'<CR>
map <Leader>v :vnew <C-R>=escape(expand("%:p:h"), ' ') . '/'<CR>

" Rubocop fix current file
nmap <leader>rc :call RubocopAutoFix()<CR>

command! Q q " Bind :Q to :q
command! Qall qall
command! W w
nnoremap <C-y> :YRShow<cr>
let g:ctrlp_map = '<c-e>'
nmap <F8> :TagbarToggle<CR>
nmap <F7> :setlocal spell! spell?<CR>
" Toggle relative numbers
map <Leader>n :call NumberToggle()<CR>
" Toggle dark/ligh colortheme
map <Leader>c :call ColorToggle()<CR>


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

" Undo
set undolevels=10000
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
let g:deoplete#enable_smart_case = 1
let g:deoplete#omni_patterns = {}
let g:deoplete#omni_patterns.ruby = ['[^. *\t]\.\w*', '\h\w*::']
let g:deoplete#sources = {}
let g:deoplete#sources._ = ['buffer', 'tag']

" Notes
let g:notes_directories = ['~/Dropbox/Notes']

let g:rspec_command = "!if [ -f ./bin/rspec ]; then; ./bin/rspec {spec}; else; bundle exec rspec {spec}; fi;"

" Ctrl-P
let g:ctrlp_working_path_mode = 'rw'
if executable('ag')
  let g:ctrlp_user_command = 'ag %s -i --nocolor --nogroup --hidden
      \ --ignore .git
      \ --ignore .svn
      \ --ignore .hg
      \ --ignore .DS_Store
      \ -g ""'
  let g:ctrlp_use_caching = 0
else
  let g:ctrlp_custom_ignore = '\v[\/]\.(git|hg|svn|log)$'
  let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files . --cached --exclude-standard --others']
endif

" Don't jump to already open window. This is annoying if you are maintaining
" several Tab workspaces and want to open two windows into the same file.
let g:ctrlp_switch_buffer = 1

" Airline
let g:airline#extensions#tabline#enabled = 1
let g:airline_powerline_fonts = 1
let g:tmuxline_powerline_separators = 0
let g:airline_left_sep = ''
let g:airline_right_sep = ''
let g:airline_section_z = ''

" Neomake
let g:neomake_ruby_reek_maker_errorformat =
        \ '%E%.%#: Racc::ParseError: %f:%l :: %m,' .
        \ '%W%f:%l: %m'
let g:neomake_ruby_reek_maker = {
    \ 'args': ['--single-line'],
    \ 'errorformat': g:neomake_ruby_reek_maker_errorformat,
    \ }
let g:neomake_ruby_reek_exe = $HOME . '/.rbenv/versions/2.2.3/bin/reek'
let g:neomake_ruby_rubocop_exe = $HOME . '/.rbenv/versions/2.2.3/bin/rubocop'
let g:neomake_ruby_enabled_makers = ['mri', 'rubocop', 'reek']
autocmd! BufWritePost * Neomake " Run on file write
nnoremap <Leader>l :lopen<CR>tocmd! BufWritePost * Neomake

let g:ctrlp_custom_ignore = '/\.\|\.o\|\.so|\.log'

" JS libs
let g:used_javascript_libs = 'jquery,angularjs,underscore'

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

" Plugin's key-mappings.
imap <C-k>     <Plug>(neosnippet_expand_or_jump)
smap <C-k>     <Plug>(neosnippet_expand_or_jump)
xmap <C-k>     <Plug>(neosnippet_expand_target)

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

" The silver searcher
let g:ag_working_path_mode="r"

" Tags
set tags+=,ruby.tags
set tags+=,coffee.tags

" ruby
autocmd FileType ruby,eruby,yaml,haml setlocal iskeyword+=?

" Autocomplete

autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags

" syntax Bowerfile as ruby
au BufRead,BufNewFile Bowerfile setfiletype ruby
" Markdown
autocmd BufRead,BufNewFile *.md set filetype=markdown
autocmd FileType markdown setlocal spell
autocmd BufRead,BufNewFile *.md setlocal textwidth=80

"""""""""""""""""""""""""
" Custom functions
"""""""""""""""""""""""""

"Toggle arrow keys

function! RubocopAutoFix()
  exe "w"
  silent exe "!rubocop -a -R % &> /dev/null"
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
" autocmd BufReadPost *
"     \ if line("'\"") > 0 && line ("'\"") <= line("$") |
"     \     exe "normal g'\"" |
"     \ endif |

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
