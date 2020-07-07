let os = substitute(system('uname'), "\n", "", "")

call plug#begin('~/.vim/plugged')

Plug 'morhetz/gruvbox'
Plug 'chusiang/vim-sdcv' " How to install dict see https://askubuntu.com/questions/191125/is-there-an-offline-command-line-dictionary
Plug 'kassio/neoterm'
Plug 'janko-m/vim-test'
Plug 'benekastah/neomake'
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'Shougo/neco-syntax'
" Plug 'tbodt/deoplete-tabnine', { 'do': './install.sh' }
Plug 'plasticboy/vim-markdown', { 'for': 'markdown' }
Plug 'itchyny/lightline.vim'
Plug 'shinchu/lightline-gruvbox.vim'
Plug 'vim-ruby/vim-ruby'
Plug 'tpope/vim-rake', { 'for': 'ruby' }
Plug 'tpope/vim-surround'
Plug 'tpope/vim-rails'
Plug 'tpope/vim-rbenv', { 'for': 'ruby' }
Plug 'tpope/vim-bundler', { 'for': 'ruby' }
Plug 'Keithbsmiley/rspec.vim', { 'for': 'ruby' }
Plug 'thoughtbot/vim-rspec', { 'for': 'ruby' }
Plug 'tpope/vim-vinegar'
Plug 'tpope/vim-endwise'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-abolish'
Plug 'tpope/vim-fugitive'
Plug 'junegunn/gv.vim'
Plug 'tpope/vim-haml', { 'for': ['haml'] }
Plug 'slim-template/vim-slim', { 'for': ['slim'] }
Plug 'tomtom/tcomment_vim'
Plug 'nelstrom/vim-textobj-rubyblock', { 'for': ['ruby'] }
  Plug 'kana/vim-textobj-user', { 'for': ['ruby'] }
Plug 'thinca/vim-localrc'
Plug 'jgdavey/vim-blockle'
Plug 'othree/eregex.vim'
Plug 'wakatime/vim-wakatime'
Plug 'othree/html5.vim'
Plug 'xolox/vim-misc'
Plug 'xolox/vim-notes'
Plug 'Shougo/neco-syntax'
Plug 'easymotion/vim-easymotion'
Plug 'junegunn/vim-easy-align'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'mileszs/ack.vim'
Plug 'mustache/vim-mustache-handlebars'
Plug 'othree/javascript-libraries-syntax.vim', { 'for': ['javascript', 'javascript.jsx'] }
Plug 'kchmck/vim-coffee-script', { 'for': ['coffee', 'haml', 'eruby'] }
Plug 'mxw/vim-jsx', { 'for': 'javascript.jsx' }
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
Plug 'othree/jspc.vim', { 'for': ['javascript', 'javascript.jsx'] }
Plug 'ap/vim-css-color'
Plug 'editorconfig/editorconfig-vim'
Plug 'rhysd/vim-grammarous'
Plug 'cespare/vim-toml'
Plug 'bfredl/nvim-miniyank'
Plug 'int3/vim-extradite'
Plug 'dzeban/vim-log-syntax'
Plug 'stephpy/vim-yaml'

" Other languages
Plug 'myint/clang-complete', { 'for': ['c', 'cpp'] }
Plug 'rhysd/vim-crystal', { 'for': 'crystal' }
Plug 'fatih/vim-go', { 'for': 'go' }
Plug 'zchee/deoplete-go', { 'for': 'go', 'do': 'make'}
" Plug 'vim-scripts/groovy.vim', { 'for': 'groovy' }
" Plug 'elixir-lang/vim-elixir', { 'for': 'elixir' }

call plug#end()

" set Python
if os == 'Darwin' || os == 'Mac'
  let g:python_host_prog  = '/usr/local/bin/python'
  let g:python3_host_prog  = '/usr/local/bin/python3'
endif

set termguicolors " true colors
set exrc " loads project spedific .nvimrc

"-----------------------
"""""""""""""""""""""""""
" KEYBINDINGS
"""""""""""""""""""""""""
let mapleader=","
inoremap jj <ESC>
map <Leader>r "hy:%S/<C-r>h//gc<left><left><left>
map <Leader>f *
map <Leader>rr :!ruby %<CR>
map <Leader>w :w<CR>
map <Leader>qa :wqa<CR>
map <Leader>[ :bprevious<CR>
map <Leader>] :bnext<CR>
map <Leader>p "+p<CR>
map <Leader>y "+y<CR>
map <Leader>D "_dd<CR>
map <Leader>d "_d<CR>
map <Leader>t :Ttoggle<CR>
map // :TComment<CR>
map <Leader>r8 :vertical resize 80<CR>
map <Leader>r12 :vertical resize 130<CR>
map <F5> :so $MYVIMRC<CR>
nnoremap <leader>. :Tags <CR>
nnoremap <Leader>fu :BTags<Cr>
nnoremap <C-e> :Buffers<CR>
" fix method jumping
nnoremap <buffer><silent> <C-]> :tag <C-R><C-W><CR>

" run set tests
nmap <silent> <leader>R :TestNearest<CR>
nmap <silent> <leader>T :TestFile<CR>
nmap <silent> <leader>A :TestSuite<CR>
nmap <silent> <leader>L :TestLast<CR>
nmap <silent> <leader>G :TestVisit<CR>

" Explain current word from dictionary
nmap <silent> <leader>d :call SearchWord()<CR>

" Useful maps
" closes the all terminal buffers
nnoremap <Leader>tc :call neoterm#close_all()<cr>
" clear terminal
nnoremap <Leader>tl :call neoterm#clear()<cr>

" clear highlight
map <Leader><Leader>h :set hlsearch!<CR>

" regenerate CTAGS - https://github.com/universal-ctags/ctags
map <Leader>ct :silent !ctags -R --exclude="*min.js"<CR>

" Devdocs docs
command! -nargs=? DevDocs :call system('type -p open >/dev/null 2>&1 && open http://devdocs.io/#q=<args> || xdg-open http://devdocs.io/#q=<args>')
au FileType python,ruby,rspec,javascript,html,php,eruby,coffee,haml nmap <buffer> K :exec "DevDocs " . fnameescape(expand('<cword>'))<CR>

" Grammarous
let g:grammarous#default_comments_only_filetypes = {
            \ '*' : 1, 'help' : 0, 'markdown' : 0,
            \ }

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
xmap ea <Plug>(EasyAlign)
" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ea <Plug>(EasyAlign)

command! Q q " Bind :Q to :q
command! Qall qall
command! W w
" FZF
nnoremap <C-f> :FZF<cr>
let $FZF_DEFAULT_COMMAND = 'ag -g ""'

nmap <F7> :setlocal spell! spell?<CR>
" Toggle relative numbers
map <Leader>n :call NumberToggle()<CR>
" Toggle dark/ligh colortheme
map <Leader>c :call ColorToggle()<CR>

" Open Neomake warning/error split
nnoremap <Leader><Leader>l :lopen<CR>tocmd! BufWritePost * Neomake

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
set secure
set lazyredraw
set splitbelow
set splitright
set diffopt+=vertical
set shell=/bin/zsh
scriptencoding utf-8
set encoding=utf-8
set termencoding=utf-8
set clipboard=unnamed
filetype plugin indent on " Do filetype detection and load custom file plugins and indent files
set laststatus=2          " When you go into insert mode,
                          " the status line color changes.
                          " When you leave insert mode,
                          " the status line color changes back.

" Display options
syntax on
set pastetoggle=<F12>
set nocursorline
set number
set list!                       " Display unprintable characters
set listchars=tab:▸\ ,trail:•,extends:»,precedes:«
autocmd filetype html,xml,go set listchars=tab:\│\ ,trail:-,extends:>,precedes:<,nbsp:+
colorscheme gruvbox
let g:gruvbox_contrast_dark = "medium" " soft, medium, hard
let g:gruvbox_contrast_light = "medium"
set background=dark
set t_ut= " fixes transparent BG on tmux

" Always edit file, even when swap file is found
set shortmess+=A
set hidden                         " Don't abandon buffers moved to the background
set wildmenu                       " Enhanced completion hints in command line
set backspace=eol,start,indent     " Allow backspacing over indent, eol, & start
set complete=.,w,b,u,U,t,i,d       " Do lots of scanning on tab completion
set completeopt-=preview           " Do not show preview window, just the menu
set directory=~/.config/nvim/swap  " Directory to use for the swap file
set diffopt=filler,iwhite          " In diff mode, ignore whitespace changes and align unchanged lines
set nowrap
set visualbell
set mouse=a

" Relative line numbers
set norelativenumber
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
let &colorcolumn="80,".join(range(131,999),",")

" terminal colors
let g:terminal_color_0  = '#2e3436'
let g:terminal_color_1  = '#cc0000'
let g:terminal_color_2  = '#4e9a06'
let g:terminal_color_3  = '#c4a000'
let g:terminal_color_4  = '#3465a4'
let g:terminal_color_5  = '#75507b'
let g:terminal_color_6  = '#0b939b'
let g:terminal_color_7  = '#d3d7cf'
let g:terminal_color_8  = '#555753'
let g:terminal_color_9  = '#ef2929'
let g:terminal_color_10 = '#8ae234'
let g:terminal_color_11 = '#fce94f'
let g:terminal_color_12 = '#729fcf'
let g:terminal_color_13 = '#ad7fa8'
let g:terminal_color_14 = '#00f5e9'
let g:terminal_color_15 = '#eeeeec'

"""""""""""""""""""""""""
" Plugin's
"""""""""""""""""""""""""
" Ack.vimm
cnoreabbrev ag Ack -Q
cnoreabbrev aG Ack -Q
cnoreabbrev Ag Ack -Q
cnoreabbrev AG Ack -Q
cnoreabbrev F Ack -Q
cnoreabbrev f Ack -Q
if executable('ag')
  let g:ackprg = 'ag --vimgrep --smart-case'
endif

" Use deoplete.
let g:deoplete#enable_at_startup = 1
call deoplete#custom#source('_', 'max_candidates', 3)
call deoplete#custom#source('buffer', 'rank', 501)
call deoplete#custom#source('buffer', 'max_candidates', 2)
" call deoplete#custom#source('tabnine', 'rank', 50)

" deoplete-go settings
let g:deoplete#sources#go#gocode_binary = $GOPATH.'/bin/gocode'
let g:deoplete#sources#go#sort_class = ['package', 'func', 'type', 'var', 'const']

" use tab
imap <silent><expr> <TAB>
  \ pumvisible() ? "\<C-n>" :
  \ <SID>check_back_space() ? "\<TAB>" :
  \ deoplete#mappings#manual_complete()
function! s:check_back_space() abort "{{{
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~ '\s'
endfunction"}}}

" For clang with
let g:clang_complete_auto = 0
let g:clang_auto_select = 0
let g:clang_omnicppcomplete_compliance = 0
let g:clang_make_default_keymappings = 0
let g:clang_library_path = '/usr/local/opt/llvm/lib'

" Ultisnip
let g:UltiSnipsExpandTrigger="<C-j>"
let g:UltiSnipsSnippetsDir="~/.config/nvim/UltiSnips"


" Notes
let g:notes_directories = ['~/Dropbox/Notes']
let g:notes_tab_indents = 0
let g:notes_word_boundaries = 1

" Lightline
let g:lightline = {
      \ 'colorscheme': 'gruvbox',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'readonly', 'filename', 'modified' ] ]
      \ },
      \ 'component_function': {
      \   'gitbranch': 'fugitive#head',
      \   'filename': 'LightlineFilename'
      \ },
      \ }

" Vim test
let test#strategy = "neoterm"

" Neomake
" let g:neomake_verbose = 3
let g:neomake_logfile = '/tmp/neomake.log'
let g:neomake_ruby_reek_maker = {
    \ 'args': '--single-line',
    \ 'errorformat':
    \   '%E%.%#: Racc::ParseError: %f:%l :: %m,' .
    \   '%W%f:%l: %m'
    \ }
" let b:neomake_ruby_flog_args = ['-t 10']
let g:neomake_ruby_enabled_makers = ['mri', 'rubocop', 'reek']
let g:neomake_javascript_enabled_makers = ['eslint']
let g:neomake_serialize = 1
let g:neomake_serialize_abort_on_error = 1

function! MyOnBattery()
  if filereadable('/usr/bin/pmset')
    silent exe "!pmset -g batt | grep discharging"
    return !v:shell_error
  else
    return readfile('/sys/class/power_supply/AC/online') == ['0']
  endif
endfunction
if MyOnBattery()
  call neomake#configure#automake('w')
else
  call neomake#configure#automake('inrw', 1000)
endif

" Neoterm
let g:neoterm_clear_cmd = "clear; printf '=%.0s' {1..80}; clear"
let g:neoterm_run_tests_bg = 1
let g:neoterm_raise_when_tests_fail = 1
let g:neoterm_default_mod = 'botright'
let g:neoterm_size = 10
let g:neoterm_autoscroll = 1

let g:neoterm_rspec_lib_cmd = 'bundle exec rspec'

" JS libs
let g:used_javascript_libs = 'jquery,handlebars,underscore,backbone'

" ignored files
set wildignore+=tags
set wildignore+=*/tmp/*
set wildignore+=*/spec/vcr/*
set wildignore+=*/public/*
set wildignore+=*/coverage/*
set wildignore+=*.png,*.jpg,*.otf,*.woff,*.jpeg,*.orig

" Markdown
let g:vim_markdown_folding_disabled=1

" EasyMotion
" Use uppercase target labels and type as a lower case
let g:EasyMotion_use_upper = 1
" type `l` and match `l`&`L`
let g:EasyMotion_smartcase = 1
" Smartsign (type `3` and match `3`&`#`)
let g:EasyMotion_use_smartsign_us = 1

" ruby
autocmd FileType ruby,eruby,yaml,haml setlocal iskeyword+=?
autocmd FileType ruby,eruby,yaml,haml setlocal iskeyword+=!
autocmd FileType ruby compiler ruby


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

" Turn on spellcheck
autocmd Filetype gitcommit,markdown,note setlocal spell textwidth=72
autocmd Filetype gitcommit,markdown,note setlocal complete+=kspell

" Crystal
" ecr - like erb
autocmd BufRead,BufNewFile *.ecr set filetype=.html.eruby

" Golang
au FileType go nmap <leader>R <Plug>(go-run)
au FileType go nmap <leader>B <Plug>(go-build)
au FileType go nmap <leader>T <Plug>(go-test)
au FileType go nmap <leader>C <Plug>(go-coverage)

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

function! LightlineFilename()
  return &filetype ==# 'vimfiler' ? vimfiler#get_status_string() :
        \ &filetype ==# 'unite' ? unite#get_status_string() :
        \ &filetype ==# 'vimshell' ? vimshell#get_status_string() :
        \ expand('%:t') !=# '' ? expand('%:p:h:t') . '/' . expand('%:t') : '[No Name]'
endfunction

if $VIM_CRONTAB == "true"
    set nobackup
    set nowritebackup
endif
