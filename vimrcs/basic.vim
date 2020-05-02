" ###########################################################
" # File Name     : basic.vim
" # Author        : Mou Tong
" # Email         : mou.tong@qq.com
" # Created Time  : 2018-01-26 08:00
" # Last Modified : 2020-05-03 00:13
" # By            : Mou Tong
" # Description   : basic config for vim
" ###########################################################

" General {{{ "

" Environment - Encoding, Indent, Fold {{{ "

set nocompatible " be iMproved required

if !isdirectory(expand("~/.vim/"))
    call mkdir($HOME . "/.vim")
endif

set title
set ttyfast " Improves smoothness of redrawing

" Don't redraw while executing macros (good performance config)
set lazyredraw

" No annoying sound on errors
set belloff=all
set t_vb=
set tm=500

" Configure backspace so it acts as it should act
set backspace=eol,start,indent

let $user_name  = "dalu"
let $tuser_name = "Mou Tong"
let $user_email = "mou.tong@qq.com"

" Set utf8 as standard encoding
set encoding=utf-8
set fileencodings=utf-8,gb18030,default,cp936,big5,latin1

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

set autoindent " Auto indent
set smartindent " Smart indent

" Enable filetype plugins
filetype on
filetype plugin on
filetype plugin indent on

" 1 tab == 4 spaces
set shiftwidth=4
set tabstop=4
set softtabstop=4
set smarttab

set expandtab " Use space instead of tabs
set wrap " Wrap lines

" Popup confirm when edit unsave or readonly files
set confirm

" Enable clipboard if possible
if has('clipboard')
    if has('unnameplus') " When possible use + register for copy-paste
        set clipboard=unnamed,unnamedplus
    else " On macOS and Windows, use * register for copy-paste
        set clipboard=unnamed
    endif
endif

" set iskeyword+=-
set whichwrap+=<,>,h,l,[,]

" Enable mouse in terminal
set mouse=a
set selection=exclusive
set selectmode=mouse,key

" Clear vert split and empty line fillchar
set fillchars=vert:│,fold:·

" Use these symbols for invisible chars
set listchars=tab:¦\ ,eol:¬,trail:⋅,extends:»,precedes:«

" Fold code config
set foldenable
set foldmethod=marker

" }}} Environment - Encoding, Indent, Fold "

" Appearence - Scrollbar, Highlight, Numberline {{{ "

" Enable syntax highlighting
syntax enable
syntax on

" set vim colors
" use true colors in vim under tmux
" @ https://github.com/tmux/tmux/issues/1246
" @ https://github.com/vim/vim/issues/993#issuecomment-255651605
if has("termguicolors") && !has('nvim')
    let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
    let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
    set termguicolors " use 24-bit colors
elseif has('nvim')
    set termguicolors " use 24-bit colors
else
    set t_Co=256 " Using 256 colors
endif

" set cursor shape
if has('nvim') || has('gui_running')
    set guicursor=n:block-blinkon0
    set guicursor=v-r:hor20-blinkon0
    set guicursor=i:ver20-blinkon0
    set guicursor=c-ci:ver20-blinkon0
    set guicursor+=a:blinkon0 " no cursor blink
else
    " Cursor Shape
    " NOTE the value can be different in different terminals
    set t_SI = "\<Esc>]50;CursorShape=1\x7"
    set t_SR = "\<Esc>]50;CursorShape=2\x7"
    set t_EI = "\<Esc>]50;CursorShape=0\x7"
endif

" Abbrev of prompt
set shortmess=aoOtTF

" Highlight current line
set cursorline

" Hide mouse pointer when type
set mousehide

" Always show current position
set ruler

" Highlight chars when over 80 rows
" augroup vimrc_autocmds
   " autocmd BufEnter * highlight OverLength ctermbg=red ctermfg=white guibg=red guifg=white
   " autocmd BufEnter * match OverLength /\%81v.*/

" Set line number
" set number
" set relativenumber

" function - linenum {{{ "

" Show line number by default
if !exists('g:rc_show_line_number')
    let g:rc_show_line_number = 1
else
    " If show_line_number is explicitly set to false,
    " events-driving UseAbsOrRelNum will be stopped.
    if g:rc_show_line_number == 0 | augroup! rc_line_number | endif
endif

" Toggle showing line number
let g:rc_linenr_switch = g:rc_show_line_number
nnoremap <silent> <Leader>n :call RCToggleLineNumber(g:rc_linenr_switch)<CR>

function! RCToggleLineNumber(switch)
    if a:switch
        set number relativenumber
        let g:rc_linenr_switch = 0
    else
        set nonumber norelativenumber
        let g:rc_linenr_switch = 1
    endif
endfunction

" Run once to show initial linenum
call RCToggleLineNumber(g:rc_show_line_number)

" Use absolute linenum in insert mode; relative linenum in normal mode
augroup rc_line_number
    autocmd FocusLost,InsertEnter * call RCUseAbsOrRelNum(1)
    autocmd FocusGained,InsertLeave * call RCUseAbsOrRelNum(0)
augroup END

function! RCUseAbsOrRelNum(switch)
    if g:rc_show_line_number == 0 || exists('#goyo')
        set nonumber norelativenumber
    else
        if a:switch
            set number norelativenumber
        else
            set number relativenumber
        endif
    endif
endfunction

" }}} linenum - function "

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
set scrolloff=3

" }}} Appearance - Scrollbar, Highlight, Numberline "

" Edit - Navigation, History, Search {{{ "

" session config
set sessionoptions-=options " do not store global and local values in a session
set sessionoptions-=folds " do not store folds

" function - restore last session {{{ "

function! MakeSession(overwrite)
  let b:sessiondir = $HOME . "/.vim/sessions" . getcwd()
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

" Adding automatons for when entering or leaving Vim
if(argc() == 0)
  au VimEnter * nested :call LoadSession()
  au VimLeave * :call MakeSession(1)
else
  au VimLeave * :call MakeSession(0)
endif

" }}} function - restore last session "

" Set to auto read when a file is changed from the outside
set autoread

" Automatically write a file after milliseconds nothing is typed
" Will get bad experience for diagnostics when it's default 4000
set updatetime=300

" Sets how many lines of history VIM has to remember
set history=1000 " command line history

" Turn backup off, since most stuff is in git et.c anyway...
" And plugins demand such as `coc`...
set nobackup
set nowritebackup

" Swap files are necessary when crash recovery
set directory=$HOME/.vim/swapfiles/

" Turn persistent undo on,
" means that you can undo even when you close a buffer/VIM
if has('persistent_undo')
    set undodir=$HOME/.vim/undotree/
    set undofile
    set undolevels=1000
endif

" For regular expressions turn magic on
set magic

" Ignore case when searching
set ignorecase

" When searching try to be smart about cases
set smartcase

" Highlight search results
set hlsearch

" Makes search act like search in modern browsers
set incsearch

" Don't wrap around when junping between search result
set nowrapscan
"
" Netrw config
let g:netrw_liststyle = 3
let g:netrw_winsize = 30
autocmd FileType netrw setlocal bufhidden=delete

" }}} Edit - Navigation, History, Search "

" Buffer - BufferSwitch, FileExplorer, Statusline {{{ "

" A buffer becomes hidden when it's abandoned
set hidden

" Specify the behavior when switching between buffers
set switchbuf=useopen
set showtabline=1
set tabpagemax=50

set splitright " Puts new vsplit windows to the right of the current
set splitbelow " Puts new split windows to the bottom of the current

" Split management
nmap <silent> <M-j> :exe "resize " . (winheight(0) * 3/2)<CR>
nmap <silent> <M-k> :exe "resize " . (winheight(0) * 2/3)<CR>
nmap <silent> <M-h> :exe "vertical resize " . (winwidth(0) * 3/2)<CR>
nmap <silent> <M-l> :exe "vertical resize " . (winwidth(0) * 2/3)<CR>

" 0 means never show, 1 means show only if there are at least two windows
" 2 means always show
set laststatus=2
set statusline=%<%f\ " filename
set statusline+=%w%h%m%r " option
set statusline+=\ [%{&ff}]/%y " fileformat/filetype
set statusline+=\ [%{getcwd()}] " current dir
set statusline+=\ [%{&encoding}] " encoding
set statusline+=%=%-14.(%l/%L,%c%V%)\ %p%% " Right aligned file nav info

" }}} Buffer - BufferSwitch, FileExplorer, StatusLine "

" GUI Related {{{ "

" Set gui font
set guifont=Sarasa\ Mono\ SC:h12

set guitablabel=%N:%M%t " show table numbers

" Disable scrollbars
set guioptions-=r
set guioptions-=R
set guioptions-=l
set guioptions-=L
set guioptions-=T " Also disable toolbar

" Properly disable sound on errors on MacVim
if has("gui_macvim")
    autocmd GUIEnter * set vb t_vb=
endif

" }}} GUI Releated "

" Neovim Related {{{ "

" Enable to continue where you left
if has('nvim')
    set shada=!,'100,<50,s10,h
else
    set viminfo='100,s10,<50
endif

" add mouse support to nvim
if !has('nvim')
    set ttymouse=xterm2
endif

if has('nvim')
    tnoremap <Esc> <C-\><C-n>
endif

if exists(':tnoremap')
    tnoremap <Esc> <C-\><C-n>
endif

" Set cursor type
" NOTE different terminal the value of `\<Esc>]<n>' can be different
" Neovim set cursor type
if has('nvim')
else
    " start insert mode (bar cursor shape)
    let &t_SI = "\<Esc>]12;CursorShape=1\x7"
    " start replace mode (underline cursor shape)
    let &t_SR = "\<Esc>]12;CursorShape=2\x7"
    " end insert or replace mode (block cursor shape)
    let &t_EI = "\<Esc>]12;CursorShape=0\x7"
endif

" tabline. Replaced by `guitablabel' when GUI is running
if has('nvim')
else
    set tabline=%N:%M%t
endif

" }}} Neovim Related "

" Misc {{{ "

" vertical diffsplit
set diffopt+=vertical

" Show matching brackets when text indicator is over them
set showmatch
" How many tenths of a second to blink when matching brackets
set matchtime=2

" Define how to use the CTRL-A and CTRL-X commands for adding to and subtracting from a number respectively
set nrformats=bin,hex

augroup dalu_color_warning
    autocmd!
    " ColorScheme means to match keywords after loading a color scheme
    " Syntax means to match keywords when the `syntax` option has been set
    " More details can be checked by `:help autocmd`
    autocmd ColorScheme * call matchadd('Todo', '\W\zs\(TODO\|FIXME\|CHANGED\|BUG\|HACK\|XXX\|NOTICE\|WARNING\|DANGER\|DEPRECATED\|REVIEW\)')
    autocmd Syntax * call matchadd('Debug', '\W\zs\(NOTE\|INFO\|IDEA\)')
augroup END

" call pyenv when using neovim
if has("nvim")
    let g:python_host_prog  = $HOME . "/.pyenv/versions/neovim2/bin/python"
    let g:python3_host_prog = $HOME . "/.pyenv/versions/neovim3/bin/python"
endif

" Make TOhtml behavior better
let g:html_dynamic_folds = 1
let g:html_prevent_copy = "fntd"

" }}} Misc "

" }}} General "
