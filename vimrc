" PLUGINS
set nocompatible
filetype off
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'gmarik/Vundle.vim'
" Plugin 'takac/vim-hardtime'
Plugin 'smeggingsmegger/ag.vim'
Plugin 'kchmck/vim-coffee-script'
Plugin 'kien/ctrlp.vim'
Plugin 'Raimondi/delimitMate'
" themes
Plugin 'morhetz/gruvbox'
Plugin 'vim-scripts/wombat256.vim'
Plugin 'altercation/vim-colors-solarized'

Plugin 'kris89/vim-multiple-cursors'
Plugin 'plasticboy/vim-markdown'
Plugin 'bling/vim-airline'
Plugin 'edkolev/tmuxline.vim'
Plugin 'vim-ruby/vim-ruby'
Plugin 'tpope/vim-projectionist'
Plugin 'tpope/vim-rake'
Plugin 'tpope/vim-rails'
Plugin 'tpope/vim-vinegar'
Plugin 'tpope/vim-endwise'
Plugin 'tpope/vim-surround'
Plugin 'tpope/vim-repeat'
Plugin 'tpope/vim-rbenv'
Plugin 'tpope/vim-abolish'
Plugin 'tpope/vim-fugitive'
Plugin 'Keithbsmiley/rspec.vim'
Plugin 'thoughtbot/vim-rspec'
Plugin 'scrooloose/syntastic'
Plugin 'majutsushi/tagbar'
Plugin 'tomtom/tcomment_vim'
Plugin 'nelstrom/vim-textobj-rubyblock'
  Plugin 'kana/vim-textobj-user'
  Plugin 'edsono/vim-matchit'
Plugin 'thinca/vim-localrc'
Plugin 'alpaca-tc/beautify.vim'
Plugin 'jgdavey/vim-blockle'
Plugin 'Lokaltog/vim-easymotion'
Plugin 'othree/javascript-libraries-syntax.vim'
Plugin 'Valloric/YouCompleteMe'
Plugin 'Shougo/neosnippet.vim'
Plugin 'Shougo/neosnippet-snippets'
Plugin 'lukaszkorecki/CoffeeTags'
Plugin 'othree/eregex.vim'
Plugin 'wakatime/vim-wakatime'
Plugin 'elixir-lang/vim-elixir'
Plugin 'airblade/vim-gitgutter'
Plugin 'sjl/gundo.vim'
Plugin 'jaxbot/browserlink.vim'
Plugin 'vhladama/vim-rubyhash'

call vundle#end()
filetype plugin indent on

"-----------------------
"""""""""""""""""""""""""
" KEYBINDINGS
"""""""""""""""""""""""""
let mapleader=","
inoremap jj <ESC>
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
" RSpec.vim mappings
map <Leader>T :call RunCurrentSpecFile()<CR>
map <Leader>R :call RunNearestSpec()<CR>
map <Leader>L :call RunLastSpec()<CR>
map <Leader>A :call RunAllSpecs()<CR>
" clear highlight
map <F3> :set hlsearch!<CR>
" search&replace current word
map <Leader>rr :%S@<C-r><C-w>@
" reload browser
map <Leader>r :BLReloadPage<CR>

" regenerate CTAGS with ripper-tags
map <Leader>ct :!ripper-tags -R --exclude=vendor<CR>

" Devdocs docs
command! -nargs=? DevDocs :call system('xdg-open http://devdocs.io/#q=<args> &')
au FileType python,ruby,rspec,javascript,html,php,eruby,coffee nmap <buffer> K :exec "DevDocs " . fnameescape(expand('<cword>'))<CR>

" Gundo
nnoremap <F6>:call GundoToggle()<CR>

" Edit another file in the same directory as the current file
" uses expression to extract path from current file's path
map <Leader>e :e <C-R>=escape(expand("%:p:h"),' ') . '/'<CR>
map <Leader>s :split <C-R>=escape(expand("%:p:h"), ' ') . '/'<CR>
map <Leader>v :vnew <C-R>=escape(expand("%:p:h"), ' ') . '/'<CR>

" Rubocop fix current file
nmap <leader>rc :call Rubocop()<CR>

" " Hardtime
" let g:hardtime_default_on = 1
" let g:hardtime_ignore_quickfix = 1

" window
nmap <leader>sw<left>  :topleft  vnew<CR>
nmap <leader>sw<right> :botright vnew<CR>
nmap <leader>sw<up>    :topleft  new<CR>
command! Q q " Bind :Q to :q
command! Qall qall
command! W w
nnoremap <C-y> :YRShow<cr>
let g:ctrlp_map = '<c-e>'
nmap <F8> :TagbarToggle<CR>
nmap <F7> :setlocal spell! spell?<CR>
map <Leader>n :call NumberToggle()<CR>

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
set t_Co=256
set term=xterm-256color
colorscheme gruvbox
let g:gruvbox_termcolors = 256
let g:gruvbox_contrast = 'hard'
set background=dark
let g:rehash256 = 1
set t_ut= " fixes transparent BG on tmux

" Always edit file, even when swap file is found
set shortmess+=A
set hidden                      " Don't abandon buffers moved to the background
set wildmenu                    " Enhanced completion hints in command line
set backspace=eol,start,indent  " Allow backspacing over indent, eol, & start
set complete=.,w,b,u,U,t,i,d    " Do lots of scanning on tab completion
set directory=~/.vim/swap       " Directory to use for the swap file
set diffopt=filler,iwhite       " In diff mode, ignore whitespace changes and align unchanged lines
set nowrap
set visualbell
set mouse=a
if has("mouse_sgr")
  set ttymouse=sgr
else
  set ttymouse=xterm2
end

" Relative line numbers
set relativenumber
autocmd InsertLeave * :call NumberToggle()
autocmd InsertEnter * :call NumberToggle()

" Indentation and tabbing
set autoindent smartindent
set smarttab                    " Make <tab> and <backspace> smarter
set tabstop=2
set expandtab
set shiftwidth=2
set incsearch
set magic
" viminfo: remember certain things when we exit
" (http://vimdoc.sourceforge.net/htmldoc/usr_21.html)
"   %    : saves and restores the buffer list
"   '100 : marks will be remembered for up to 30 previously edited files
"   /100 : save 100 lines from search history
"   h    : disable hlsearch on start
"   "500 : save up to 500 lines for each register
"   :100 : up to 100 lines of command-line history will be remembered
"   n... : where to save the viminfo files
set viminfo=%100,'100,/100,h,\"500,:100,n~/.vim/viminfo

" Undo
set undolevels=10000
if has("persistent_undo")
  set undodir=~/.vim/undo       " Allow undoes to persist even after a file is closed
  set undofile
endif

" Autosave
:au FocusLost * silent! wa

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
" Plugins
"""""""""""""""""""""""""

let g:rspec_command = "!if [ -f ./bin/rspec ]; then; ./bin/rspec {spec}; else; bundle exec rspec {spec}; fi;"
runtime macros/matchit.vim

" Ctrl-P
let g:ctrlp_working_path_mode = 'rw'
let g:ctrlp_custom_ignore = '\.git$\|\.hg$\|\.svn$'
let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files . --cached --exclude-standard --others']

" Don't jump to already open window. This is annoying if you are maintaining
" several Tab workspaces and want to open two windows into the same file.
let g:ctrlp_switch_buffer = 0

" Airline
let g:airline#extensions#tabline#enabled = 1
let g:airline_powerline_fonts = 1
let g:airline_section_z = ''

" syntastic
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_auto_loc_list=1
let g:syntastic_enable_highlighting=0
let g:syntastic_enable_signs = 1
let g:syntastic_error_symbol = '✗'
let g:syntastic_check_on_open = 1
let g:syntastic_style_error_symbol = '✗'
let g:syntastic_warning_symbol = '⚠'
let g:syntastic_style_warning_symbol = '⚠'
let g:syntastic_auto_loc_list = 0
let g:syntastic_mode_map = { 'mode': 'active',
                           \ 'active_filetypes': [],
                           \ 'passive_filetypes': ['html', 'c', 'scss'] }
let g:syntastic_ruby_checkers = ['mri', 'rubocop214']
let g:syntastic_coffee_coffeelint_args = '-f ~/.coffeelint.json'
let g:quickfixsigns_classes = ['qfl', 'vcsdiff', 'breakpoints']

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
let g:neosnippet#snippets_directory='~/.vim/neosnippets'

" Plugin key-mappings.
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

" Tags
set tags+=,ruby.tags
set tags+=,coffee.tags

" ruby
autocmd FileType ruby set omnifunc=rubycomplete#Complete
autocmd FileType ruby let g:rubycomplete_buffer_loading = 1
autocmd FileType ruby let g:rubycomplete_rails = 1
autocmd FileType ruby let g:rubycomplete_classes_in_global = 0
autocmd FileType ruby,eruby,yaml setlocal iskeyword+=?

" Enable omni completion.
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags

" Enable heavy omni completion.
if !exists('g:neocomplete#sources#omni#input_patterns')
  let g:neocomplete#sources#omni#input_patterns = {}
endif

" syntax Bowerfile as ruby
au BufRead,BufNewFile Bowerfile setfiletype ruby

"""""""""""""""""""""""""
" Custom functions
"""""""""""""""""""""""""

"Toggle arrow keys

function! Rubocop()
  exe "w"
  silent exe "!rubocop -a -R % &> /dev/null"
  silent exe "e %"
  SyntasticCheck()
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

