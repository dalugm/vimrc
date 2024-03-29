" Environment {{{

if version >= 800 && !has('nvim')
  unlet! skip_defaults_vim
  source $VIMRUNTIME/defaults.vim
elseif !has('nvim')
  " Vi IMproved
  set nocompatible
  filetype plugin indent on
endif

if !isdirectory(expand("~/.vim/"))
  call mkdir($HOME . "/.vim")
endif

set title
" Improves smoothness of redrawing
set ttyfast

" set message language
let $LANG='en_US.UTF-8'
" set menu's language
set langmenu=en

" Avoid local vimrc's problem
set secure

" Don't redraw while executing macros (good performance config)
set lazyredraw

" No annoying sound on errors
set belloff=all
set t_vb=
set tm=500

" Configure backspace so it acts as it should act
" Same as ":set backspace=2"
set backspace=indent,eol,start

" file {{{

" Inner character encoding, including buffer, menu, message, etc.
set encoding=utf-8

" File encodings, set fileencoding based on detection
set fileencodings=utf-8,gb18030,default,cp936,big5,latin1

" Solve the unreadable problem on Windows
source $VIMRUNTIME/delmenu.vim
source $VIMRUNTIME/menu.vim

" Use Unix as the standard file type
set fileformats=unix,mac,dos

" Also break at a multi-byte character above 255
set formatoptions+=m
" When joining lines, don't insert a space between two multi-byte characters
set formatoptions+=B
" Where it makes sense, remove a comment leader when joining lines
set formatoptions+=j
" When formatting text, recognize numbered lists
set formatoptions+=n

" }}} file

" indent {{{

" Auto indent
set autoindent

" Smart indent
set smartindent

" N spaces for every indent
set shiftwidth=4

" 1 tab == N spaces
set tabstop=4

" perform N spaces when edit
set softtabstop=4

" Use space instead of tabs
set expandtab

" Add `shiftwidth' spaces or `tabstop' spaces when <Tab>
set smarttab

" }}} indent

" Popup confirm when edit unsave or readonly files
set confirm

" Enable clipboard if possible
if has('clipboard')
  " When possible use + register for copy-paste
  if has('unnameplus')
    set clipboard=unnamed,unnamedplus
    " On macOS and Windows, use * register for copy-paste
  else
    set clipboard=unnamed
  endif
endif

" set iskeyword+=-
set whichwrap+=<,>,h,l,[,]

" Enable mouse in terminal
set mouse=a

" Clear vert split and empty line fillchar
set fillchars=vert:│,fold:·

" Use these symbols for invisible chars
set listchars=tab:>\ ,eol:$,trail:⋅,extends:>,precedes:<,nbsp:+

" Fold code config
set foldenable
set foldmethod=marker

" }}} Environment

" Appearence {{{

" Enable syntax highlighting
syntax enable
syntax on

" set vim colors
" use true colors in vim under tmux
" https://github.com/tmux/tmux/issues/1246
" https://github.com/vim/vim/issues/993#issuecomment-255651605
if has("termguicolors") && !has('nvim')
  let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
  let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
  set termguicolors " use 24-bit colors
elseif has('nvim')
  set termguicolors " use 24-bit colors
else
  set t_Co=256 " Using 256 colors
endif

" Abbrev of prompt
set shortmess=aoOtTF

" Hide mouse pointer when type
set mousehide

" Always show current position
set ruler

" Always show the sign column
" otherwise it would shift the text each time
set signcolumn="yes"

" Highlight chars when over 80 rows
" augroup vimrc_autocmds
"   autocmd BufEnter * highlight OverLength ctermbg=red ctermfg=white guibg=red guifg=white
"   autocmd BufEnter * match OverLength /\%81v.*/
" augroup END

" show command in the last line of screen
set showcmd

" Height of the command bar
set cmdheight=1

" Turn on the Wild menu
" Enhance command-line completion
set wildmenu
set wildmode=list:longest,full

" Ignore compiled files
set wildignore=*.so,*.swp,*.pyc,*.pyo,*.exe,*.7z

if has("win16") || has("win32")
  set wildignore+=.git\*,.hg\*,.svn\*,*\desktop.ini
else
  set wildignore+=*/.git/*,*/.hg/*,*/.svn/*,*/.DS_Store
endif

" Minimal number of screen lines to keep above and below the cursor.
set scrolloff=5

" vertical diffsplit
set diffopt+=vertical

" Show matching brackets when text indicator is over them
set showmatch

" How many tenths of a second to blink when matching brackets
set matchtime=2

" Specify the behavior when switching between buffers
set switchbuf=useopen
set showtabline=1
set tabpagemax=50

" 0 means never show, 1 means show only if there are at least two windows
" 2 means always show
set laststatus=2
set statusline=%<%f\ " filename
set statusline+=%w%h%m%r " option
set statusline+=\ [%{&ff}]/%y " fileformat/filetype
set statusline+=\ [%{getcwd()}] " current dir
set statusline+=\ [%{&encoding}] " encoding
set statusline+=%=%-14.(%l/%L,%c%V%)\ %p%% " Right aligned file nav info

autocmd!
" ColorScheme means to match keywords after loading a color scheme
" Syntax means to match keywords when the `syntax` option has been set
" More details can be checked by `:help autocmd`
autocmd ColorScheme * call matchadd('Todo', '\W\zs\(TODO\|FIXME\|CHANGED\|BUG\|HACK\|XXX\|NOTICE\|WARNING\|DANGER\|DEPRECATED\|REVIEW\)')
autocmd Syntax * call matchadd('Debug', '\W\zs\(NOTE\|INFO\|IDEA\)')

" }}} Appearance

" Edit {{{

" execute `:argdo' etc. by omitting `!'
set hidden

" For regular expressions turn magic on
set magic

" When searching try to be smart about cases
set smartcase

" Highlight search results
set hlsearch

" Update preview instantly when searching
set incsearch

" Don't wrap around when junping between search result
set nowrapscan

" session config
set sessionoptions-=options  " do not store global and local values in a session
set sessionoptions-=blank    " do not store empty windows
set sessionoptions+=tabpages " store all tabpages

" function - restore last session {{{

function! MakeSession(overwrite)
  let b:sessiondir = $HOME . "/.vim/sessions"
  if (filewritable(b:sessiondir) != 2)
    exe 'silent !mkdir -p ' b:sessiondir
    redraw!
  endif
  let b:filename = b:sessiondir . '/session.vim'
  if a:overwrite == 0 && !empty(glob(b:filename))
    return
  endif
  exe "mksession! " . b:filename
endfunction

function! LoadSession()
  let b:sessiondir = $HOME . "/.vim/sessions" . getcwd()
  let b:sessionfile = b:sessiondir . "/session.vim"
  if (filereadable(b:sessionfile))
    exe 'source ' b:sessionfile
  else
    echo "No session loaded."
  endif
endfunction

" Adding automations for when entering or leaving Vim
if(argc() == 0)
  au VimLeave * :call MakeSession(1)
else
  au VimLeave * :call MakeSession(0)
endif

" }}} function - restore last session

" Set to auto read when a file is changed from the outside
set autoread

if !has('nvim') && &ttimeoutlen == -1
  set ttimeout
  set ttimeoutlen=100
endif

" Automatically write a file after milliseconds nothing is typed
" Will get bad experience for diagnostics when it's default 4000
set updatetime=300

" Sets how many lines of cmd history VIM has to remember
set history=1000

" Turn backup off, since we use git to manage it in most cases
set nobackup
set nowritebackup

" " Swap files are necessary when crash recovery
" " But I prefer to use DVCS to manange it
" " Or just backup manually out of secure problem
" set directory=$HOME/.vim/swapfiles//

" Turn persistent undo on,
" means that you can undo even when you close a buffer/VIM
if has('persistent_undo')
  set undofile
  set undolevels=1000
  set undodir=$HOME/.vim/undotree
  augroup undo
    autocmd!
    autocmd BufWritePre /tmp/* setlocal noundofile
  augroup END
endif

" Tags config
if has('path_extra')
  set tags=./.tags;,.tags,./tags;
endif

" Netrw config
let g:netrw_liststyle = 3
let g:netrw_winsize = 30
augroup netrw
  autocmd FileType netrw setlocal bufhidden=delete
augroup END

" Make auto-complete faster
set complete-=i   " disable scanning included files
set complete-=t   " disable searching tags

" Define how to use the CTRL-A and CTRL-X commands for adding to and subtracting from a number respectively
set nrformats-=octal

" Close buffer not window
command! Bd :bp | :sp | :bn | :bd

" For a better commit message
autocmd Filetype gitcommit setlocal spell textwidth=72

" }}} Edit

" Keybindings {{{

" normal mode {{{

" Split management
nnoremap <silent> <M-J> :exe "resize " . (winheight(0) * 3/2)<CR>
nnoremap <silent> <M-K> :exe "resize " . (winheight(0) * 2/3)<CR>
nnoremap <silent> <M-H> :exe "vertical resize " . (winwidth(0) * 3/2)<CR>
nnoremap <silent> <M-L> :exe "vertical resize " . (winwidth(0) * 2/3)<CR>

" Window change
nnoremap <silent> <M-j> <C-W>j
nnoremap <silent> <M-k> <C-W>k
nnoremap <silent> <M-h> <C-W>h
nnoremap <silent> <M-l> <C-W>l

" Enhance <C-l>
nnoremap <silent> <C-l> :<C-u>nohlsearch<C-R>=has('diff')?'<BAR>diffupdate':''<CR><CR>:syntax sync fromstart<CR><C-l>

" Misc keybindings
nnoremap Y y$

" }}} normal mode

" insert mode {{{

" Map jk to enter normal mode
inoremap jk <Esc>

" }}} insert mode

" enhance {{{

" Make `&' keep the flags in substitute
nnoremap & :&&<CR>
xnoremap & :&&<CR>

" Use `%%' to expand current file's dir
cnoremap <expr> %% getcmdtype() == ':' ? expand('%:h').'/' : '%%'

" Enhance `*' {{{

" makes * and # work on visual mode too.
function! s:VSetSearch(cmdtype)
  let temp = @s
  norm! gv"sy
  let @/ = '\V' . substitute(escape(@s, a:cmdtype.'\'), '\n', '\\n', 'g')
  let @s = temp
endfunction

xnoremap * :<C-u>call <SID>VSetSearch('/')<CR>/<C-R>=@/<CR><CR>
xnoremap # :<C-u>call <SID>VSetSearch('?')<CR>?<C-R>=@/<CR><CR>

" recursively vimgrep for word under cursor or selection if you hit leader-star
if maparg('<leader>*', 'n') == ''
  nmap <leader>* :execute 'noautocmd vimgrep /\V' . substitute(escape(expand("<cword>"), '\'), '\n', '\\n', 'g') . '/ **'<CR>
endif
if maparg('<leader>*', 'v') == ''
  vmap <leader>* :<C-u>call <SID>VSetSearch()<CR>:execute 'noautocmd vimgrep /' . @/ . '/ **'<CR>
endif

" }}} Enhance `*'

" }}} enhance

" LeaderKey {{{

" With a map leader it's possible to do extra key combinations
let mapleader = ","

" Use `\' to replace `,' since `,' is leaderkey
noremap \ ,

" Fast saving
nnoremap <silent> <Leader>w :update<CR>

" Fast quiting
nnoremap <silent> <Leader>Q :qa!<CR>

" Fast editing
nnoremap <Leader>ec :e! ~/.vim/init.vim<CR>
nnoremap <Leader>ee :e! .<CR>

" Fast reload
nnoremap <Leader>er :source ~/.vimrc<CR>

" Edit macros
nnoremap <Leader>em :<C-u><c-r><c-r>='let @'. v:register .' = '. string(getreg(v:register))<cr><c-f><left>

" Switch CWD to the directory of the open buffer
nnoremap <Leader>dd :lcd %:p:h<CR>:pwd<CR>

" Key Mappings - Buffer {{{

" Close the current buffer
map <Leader>bd :bdelete<CR>

" Close all the buffers
map <Leader>ba :bufdo bd<CR>

" }}} Key Mappings - Buffer

" Key Mappings - Tab {{{

map <Leader>tn :tabnew<CR>
map <Leader>to :tabonly<CR>
map <Leader>tc :tabclose<CR>
map <Leader>tm :tabmove

" Let 'tl' toggle between this and the last accessed tab
let b:lasttab = 1
nmap <Leader>tl :exe "tabn ".b:lasttab<CR>
au TabLeave * let b:lasttab = tabpagenr()

" Opens a new tab with the current buffer's path
map <Leader>te :tabedit <c-r>=expand("%:p:h")<CR>/

" }}} Key Mappings - Tab

" }}} LeaderKey

" }}} Keybindings

" Package {{{

if has('packages')
  " Enhance `%' command
  packadd! matchit
  autocmd FileType python let b:match_words = '\<if\>:\<elif\>:\<else\>,'
        \ . '\<try\>:\<except\>'
  let b:match_ignorecase=0

  " when editing a file that is already edited with another Vim instance
  " go to that Vim instance
  if !has('nvim')
    packadd! editexisting
  endif

else
  runtime macros/matchit.vim
  autocmd FileType python let b:match_words = '\<if\>:\<elif\>:\<else\>,'
        \ . '\<try\>:\<except\>'
  let b:match_ignorecase=0

  if !has('nvim')
    runtime macros/editexisting.vim
  endif

endif

" Load help doc
silent! helptags ALL

" }}} Package

" GUI Related {{{

" set cursor shape
if has ('nvim') || has('gui_running')
  set guicursor=n-v-sm:block
  set guicursor+=i-c-ci:ver25
  set guicursor+=ve-r-cr-o:hor20
  set guicursor+=a:blinkon0 " no cursor blink
endif

if has('gui_running')
  " set gui font
  set guifont=LXGW\ WenKai\ Mono:h14

  " change GUI relatives
  command! Bigger  :let &guifont = substitute(&guifont, '\d\+$', '\=submatch(0)+1', '')
  command! Smaller :let &guifont = substitute(&guifont, '\d\+$', '\=submatch(0)-1', '')

  " show table numbers
  set guitablabel=%N:%M%t

  " Disables the GUI tab line in favor of the plain text version
  set guioptions-=e
  " Disable scrollbars
  set guioptions-=L
  set guioptions-=l
  set guioptions-=R
  set guioptions-=r
  " Disable toolbar
  set guioptions-=T
endif

" }}} GUI Releated

" Neovim Related {{{

" Enable to continue where you left
if has('nvim')
  set shada=!,'100,<50,s10,h
else
  set viminfo='100,s10,<50,n$HOME/.vim/viminfo
endif

" Keybindings
if has('nvim')
  tnoremap <Esc> <C-\><C-n>
  tnoremap <C-v><Esc> <Esc>
  tnoremap <M-h> <C-\><C-n><C-w>h
  tnoremap <M-j> <C-\><C-n><C-w>j
  tnoremap <M-k> <C-\><C-n><C-w>k
  tnoremap <M-l> <C-\><C-n><C-w>l
endif

" Show TermCursor always
if has('nvim')
  highlight! link TermCursor Cursor
  highlight! TermCursorNC guibg=red guifg=white ctermbg=1 ctermfg=15
endif

" Set neovim as core.editor of git when not set
if has('nvim') && executable('nvr')
  let $VISUAL="nvr -cc split --remote-wait + 'set bufhidden=wipe'"
endif

" }}} Neovim Related

" Plugin {{{

if plug#begin('~/.vim/plugged')

  " Specify a directory for plugins
  " - Avoid using standard Vim directory names like 'plugin'
  " Make sure you use single quotes

  " better operation
  Plug 'editorconfig/editorconfig-vim'
  Plug 'easymotion/vim-easymotion'
  Plug 'LunarWatcher/auto-pairs'

  Plug 'sirver/ultisnips' | Plug 'honza/vim-snippets'
    let g:UltiSnipsExpandTrigger = "<tab>"
    let g:UltiSnipsJumpForwardTrigger = "<tab>"
    let g:UltiSnipsJumpBackwardTrigger = "<s-tab>"
    " If you want :UltiSnipsEdit to split your window.
    let g:UltiSnipsEditSplit = "vertical"
    let g:UltiSnipsSnippetDirectories = ["UltiSnips", "mysnippets"]
    let g:snips_author = "dalu"
    let g:snips_email = "mou.tong@outlook.com"
    let g:snips_github = "https://github.com/dalugm"
    let g:snips_about = "dalu <mou.tong@outlook.com>"

  Plug 'tpope/vim-commentary'
    nmap <leader>c <Plug>Commentary<CR>
    xmap <leader>c <Plug>Commentary<CR>
    omap <leader>c <Plug>Commentary<CR>
    nmap <leader>cc <Plug>CommentaryLine
    autocmd FileType apache setlocal commentstring=#\ %s

  Plug 'tpope/vim-dispatch'
    let test#strategy = "dispatch"
    " https://github.com/tpope/vim-dispatch/issues/222#issuecomment-493273080
    if !empty($TMUX)
      set shellpipe=2>&1\|tee
    endif

  Plug 'tpope/vim-abolish'
  Plug 'tpope/vim-obsession'
  Plug 'tpope/vim-repeat'
  Plug 'tpope/vim-rsi'
  Plug 'tpope/vim-surround'
  Plug 'tpope/vim-unimpaired'
  Plug 'wellle/targets.vim'

  Plug 'junegunn/vim-easy-align'
    map <Leader>g :EasyAlign<Space>
    nmap ga <Plug>(EasyAlign)
    xmap ga <Plug>(EasyAlign)

  " git
  Plug 'airblade/vim-gitgutter'
  Plug 'tpope/vim-fugitive'

  " program
  Plug 'bfrg/vim-cpp-modern'

  Plug 'mattn/emmet-vim', { 'for': ['html', 'css', 'scss', 'sass', 'less', 'vue', 'javascriptreact'] }
    let g:user_emmet_install_global = 0
    let g:user_emmet_leader_key = '<C-y>'

  Plug 'lervag/vimtex'
    let g:tex_flavor = 'xelatex'
    let g:vimtex_compiler_latexmk = {
    \   'options' : [
    \     '-xelatex',
    \     '-shell-escape',
    \     '-verbose',
    \     '-file-line-error',
    \     '-synctex=1',
    \     '-interaction=nonstopmode',
    \   ],
    \ }

  Plug 'skywind3000/asyncrun.vim'
  Plug 'skywind3000/asynctasks.vim'
    " Set the height of window when run AsyncRun
    let g:asyncrun_open = 6
    " Identify the project root directory
    " If not in any these rootmarks put an empty .root in directory
    let g:asyncrun_rootmarks = ['.svn', '.git', '.root', '.project', '.hg', 'build.xml']
    " Set terminal position and style when set output=terminal
    let g:asynctasks_term_pos = 'bottom'
    " Set default global name of AsyncTask config
    let g:asynctasks_rtp_config = "tasks.toml"

  " appearance
  Plug 'NLKNguyen/papercolor-theme'
  Plug 'arcticicestudio/nord-vim'
  Plug 'ayu-theme/ayu-vim'
  Plug 'challenger-deep-theme/vim', { 'as': 'challenger-deep' }
  Plug 'cocopon/iceberg.vim'
  Plug 'dalugm/solarized.vim'
  Plug 'dracula/vim', { 'as': 'dracula' }
  Plug 'jacoborus/tender.vim'
  Plug 'jaredgorski/spacecamp'
  Plug 'jnurmine/zenburn'
  Plug 'joshdick/onedark.vim'
  Plug 'morhetz/gruvbox'
  Plug 'nanotech/jellybeans.vim'
  Plug 'overcache/NeoSolarized'
  Plug 'rakr/vim-one'
  Plug 'srcery-colors/srcery-vim'

  Plug 'luochen1990/rainbow'
    " 0 if you want to enable it later via :RainbowToggle
    let g:rainbow_active = 1

  " update &runtimepath and initialize plugin system
  call plug#end()
else
  echo "WARNING: plug.vim undetected, now downloading...\n"
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
        \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
endif

" }}} Plugin
