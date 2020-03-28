" ###########################################################
" # File Name     : basic.vim
" # Author        : Mou Tong
" # Email         : mou.tong@qq.com
" # Created Time  : 2018-01-26 08:00
" # Last Modified : 2020-02-06 15:14
" # By            : Mou Tong
" # Description   : basic config for vim
" ###########################################################

" General {{{ "

" Environment - Encoding, Indent, Fold {{{ "

set nocompatible " be iMproved required

if !isdirectory(expand("~/.vim/"))
    call mkdir($HOME . "/.vim")
endif

set runtimepath+=$HOME/.vim

set title
set ttyfast " Improves smoothness of redrawing

" Don't redraw while executing macros (good performance config)
set lazyredraw

" No annoying sound on errors
set noerrorbells
set novisualbell
set t_vb=
set tm=500

set t_Co=256 " Using 256 colors
set t_ti= t_te = " put terminal in 'termcap' mode

" Configure backspace so it acts as it should act
set backspace=eol,start,indent

let $user_name  = "dalu"
let $tuser_name = "Mou Tong"
let $user_email = "mou.tong@qq.com"

" Set utf8 as standard encoding
set encoding=utf-8
set fileencodings=utf-8,usc-bom,default,cp936,big5,latin1

" Use Unix as the standard file type
set fileformats=unix,mac,dos

set ambiwidth=double

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

" Enable to continue where you left
" `'` means to save mark for how many files
" `f` means to if to save global variables
" `<` means to save how many text lines in viminfo
set viminfo='1000,f1,<500

" set iskeyword+=-
set whichwrap+=<,>,h,l,[,]

" Enable mouse in terminal
set mouse=a
set selection=exclusive
set selectmode=mouse,key

" Clear vert split and empty line fillchar
set fillchars=vert:\ ,stl:\ ,stlnc:\

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

" Abbrev of prompt
set shortmess=aoOtT

" Highlight current line
set cursorline

" Hide mouse pointer when type
set mousehide

" Always show current position
set ruler

" Add a bit extra margin to the left
"set foldcolumn=2

" Highlight chars when over 80 rows
"augroup vimrc_autocmds
"    autocmd BufEnter * highlight OverLength ctermbg=red ctermfg=white guibg=red guifg=white
"    autocmd BufEnter * match OverLength /\%81v.*/

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
    autocmd!
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

" Pressing ,sc will toggle and untoggle spell checking
map <Leader>sc :setlocal spell!<cr>

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
" Set this value large enough to make cursor line always be in the middle
set scrolloff=999

" }}} Appearance - Scrollbar, Highlight, Numberline "

" Edit - Navigation, History, Search {{{ "

set sessionoptions-=options " Don't restore all options and mappings

" Restore last session automatically (default off)
if !exists('g:rc_restore_last_session') | let g:rc_restore_last_session = 0 | endif

" Always save the last session
augroup save_session
    autocmd!
    autocmd VimLeave * exe ":mksession! ~/.vim/.last.session"
augroup END

" Try to restore last session
augroup restore_session
    autocmd!
    autocmd VimEnter * call RCRestoreLastSession()
augroup END

function! RCRestoreLastSession()
    if g:rc_restore_last_session
        if filereadable(expand("~/.vim/.last.session"))
           exe ":source ~/.vim/.last.session"
       endif
   endif
endfunction

" Restore the last session manually
if filereadable(expand("~/.vim/.last.session"))
    nmap <silent> <Leader>r :source ~/.vim/.last.session<CR>
endif

set completeopt=menu,preview,longest
set pumheight=10

" Automatically close the preview window when popup menu is invisible
if !exists('g:rc_auto_close_pw')
    let g:rc_auto_close_pw = 1
else
    if g:rc_auto_close_pw == 0 | augroup! rc_close_pw | end
endif

augroup rc_close_pw
    autocmd!
    autocmd CursorMovedI,InsertLeave * call RCClosePWOrNot()
augroup END

function! RCClosePWOrNot()
    if g:rc_auto_close_pw
        if !pumvisible() && (!exists('*getcmdwintype') || empty(getcmdwintype()))
            silent! pclose
        endif
    endif
endfunction

" Return to last edit position when opening files
autocmd BufReadPost *
    \ if line("'\"") >= 1 && line("'\"") <= line("$") && &ft !~# 'commit'
    \ |   exe "normal! g`\""
    \ | endif

" Set to auto read when a file is changed from the outside
set autoread

" Automatically write a file when leaving a modified buffer
" set autowrite

" Automatically write a file after milliseconds nothing is typed
" Will get bad experience for diagnostics when it's default 4000
set updatetime=300

" Sets how many lines of history VIM has to remember
set history=500 " command line history

" Turn backup off, since most stuff is in SVN, git et.c anyway...
set nobackup
set nowritebackup

" Swap files are necessary when crash recovery
call mkdir($HOME . "/.vim/swapfiles", "p")
set dir=$HOME/.vim/swapfiles//

" Turn persistent undo on,
" means that you can undo even when you close a buffer/VIM
set undofile
set undolevels=1000

call mkdir($HOME . "/.vim/undotree", "p")
set undodir=$HOME/.vim/undotree/

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

" Add fzf for better search
set rtp+=/usr/local/opt/fzf

" Don't wrap around when junping between search result
" set nowrapscan

" }}} Edit - Navigation, History, Search "

" Buffer - BufferSwitch, FileExplorer, Statusline {{{ "

" A buffer becomes hidden when it's abandoned
set hidden

" Change current working directory automatically
set autochdir

let g:netrw_liststyle = 3
let g:netrw_winsize = 30
nnoremap <silent> <Leader>ve :Vexplore <C-r>=expand("%:p:h")<CR><CR>
autocmd FileType netrw setlocal bufhidden=delete

" Specify the behavior when switching between buffers
set switchbuf=useopen
set showtabline=1

set splitright " Puts new vsplit windows to the right of the current
set splitbelow " Puts new split windows to the bottom of the current

" Split management
nnoremap <silent> [b :bprevious<cr>
nnoremap <silent> ]b :bnext<cr>
nmap <silent> <C-k> :exe "resize " . (winheight(0) * 3/2)<CR>
nmap <silent> <C-j> :exe "resize " . (winheight(0) * 2/3)<CR>
nmap <silent> <C-h> :exe "vertical resize " . (winwidth(0) * 3/2)<CR>
nmap <silent> <C-l> :exe "vertical resize " . (winwidth(0) * 2/3)<CR>

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

" Set font according to system
if has("mac") || has("macunix")
    set guifont=Sarasa\ Mono\ SC:h12
elseif has("win16") || has("win32")
    set guifont=Sarasa\ Mono\ SC:h12
elseif has("gui_gtk2")
    set guifont=Sarasa\ Mono\ SC:h12
elseif has("linux")
    set guifont=Sarasa\ Mono\ SC:h12
elseif has("unix")
    set guifont=Sarasa\ Mono\ SC:h12
endif

set guitablabel=%M\ %t
set guicursor=n:block-blinkon0
set guicursor=v-r:hor20-blinkon0
set guicursor=i:ver20-blinkon0
set guicursor=c-ci:ver20-blinkon0
set guicursor+=a:blinkon0 " no cursor blink

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

" Misc {{{ "

set noshowcmd

" vertical diffsplit
set diffopt+=vertical

" Show matching brackets when text indicator is over them
set showmatch
" How many tenths of a second to blink when matching brackets
set matchtime=2

" Define how to use the CTRL-A and CTRL-X commands for adding to and subtracting from a number respectively
set nrformats=alpha,octal,hex

augroup rc_color_warning
    autocmd!
    " ColorScheme means to match keywords after loading a color scheme
    " Syntax means to match keywords when the `syntax` option has been set
    " More details can be checked by `:help autocmd`
    autocmd ColorScheme * call matchadd('Todo', '\W\zs\(TODO\|FIXME\|CHANGED\|BUG\|HACK\|XXX\|NOTICE\|WARNING\|DANGER\|DEPRECATED\|REVIEW\)')
    autocmd Syntax * call matchadd('Debug', '\W\zs\(NOTE\|INFO\|IDEA\)')
augroup END

" Find out to which highlight-group a particular keyword/symbol belongs
command! Wcolor echo "hi<" . synIDattr(synID(line("."),col("."),1),"name") .
            \ "> trans<" . synIDattr(synID(line("."),col("."),0),"name") .
            \ "> lo<" . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") .
            \ "> fg:" . synIDattr(synIDtrans(synID(line("."),col("."),1)),"fg#")

augroup rc_ft_settings
    autocmd!
    autocmd FileType python setlocal foldmethod=indent textwidth=80
    autocmd BufNewFile,BufRead *.org setlocal filetype=org commentstring=#%s
    autocmd BufNewFile,BufRead *.tex setlocal filetype=tex
    autocmd FileType qf setlocal nowrap
augroup END

" Strip trailing spaces and blank lines of EOF when saving files
if !exists('g:rc_strip_wsbl')
    let g:rc_strip_wsbl = 1
else
    if g:rc_strip_wsbl == 0 | augroup! rc_strip_wsbl | endif
endif

augroup rc_strip_wsbl
    autocmd!
    autocmd BufWritePre * call RCStripWSBL()
augroup END

nnoremap <silent> <Leader>s :call RCStripWSBL()<CR>
function! RCStripWSBL()
    let l = line(".")
    let c = col(".")
    %s/\s\+$//ge
    %s/\(\n\)\+\%$//ge
    call cursor(l, c)
endfunction

" Make TOhtml behavior better
let g:html_dynamic_folds = 1
let g:html_prevent_copy = "fntd"

" }}} Misc "

" }}} General "
