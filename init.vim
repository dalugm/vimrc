" Basic {{{

" Disable vi compatibility, if for some reason it's on.
if &compatible
  set nocompatible
endif

set title
" Improve smoothness of redrawing.
set ttyfast

" Message language.
let $LANG='en_US.UTF-8'
" Menu language.
set langmenu=en

" Avoid local vimrc's problem.
set secure

" Don't redraw while executing macros.
set lazyredraw

" No annoying sound on errors.
set belloff=all
set t_vb=
set tm=500

" Enable to continue where you left.
set viminfo='100,s10,<50,n$HOME/.vim/viminfo

" Configure backspace so it acts as it should act.
" Same as ":set backspace=2".
set backspace=indent,eol,start

" Inner character encoding, including buffer, menu, message, etc.
set encoding=utf-8

" File encodings, set fileencoding based on detection.
set fileencodings=utf-8,gb18030,default,cp936,big5,latin1

" Use Unix as the standard file type.
set fileformats=unix,mac,dos

" Also break at a multi-byte character above 255.
set formatoptions+=m
" When joining lines, don't insert a space between two multi-byte characters.
set formatoptions+=B
" Where it makes sense, remove a comment leader when joining lines.
set formatoptions+=j
" When formatting text, recognize numbered lists.
set formatoptions+=n

" Auto indent.
set autoindent

" Smart indent.
set smartindent

" 2 spaces for every indent.
set shiftwidth=2

" 1 tab == 2 spaces.
set tabstop=2

" perform 2 spaces when edit.
set softtabstop=2

" Use space instead of tabs.
set expandtab

" Add `shiftwidth' spaces or `tabstop' spaces when press <Tab>.
set smarttab

" Popup confirm when edit unsave or readonly files.
set confirm

" Enable clipboard if possible.
if has('clipboard')
  " When possible use + register for copy-paste.
  if has('unnameplus')
    set clipboard=unnamed,unnamedplus
    " On macOS and Windows, use * register for copy-paste.
  else
    set clipboard=unnamed
  endif
endif

" set iskeyword+=-
set whichwrap+=<,>,h,l,[,]

" Enable mouse in terminal.
set mouse=a

" Clear vert split and empty line fillchar.
set fillchars=vert:│,fold:·

" Use these symbols for invisible chars.
set listchars=tab:>\ ,eol:$,trail:⋅,extends:>,precedes:<,nbsp:+

" Fold code config
set foldenable
set foldmethod=marker

if has("win16") || has("win32")
  " Solve the unreadable problem on Windows.
  source $VIMRUNTIME/delmenu.vim
  source $VIMRUNTIME/menu.vim

  set shell=pwsh
endif

" }}} Basic

" Appearence {{{

" Enable syntax highlighting.
syntax enable
syntax on

" Use true colors in vim under tmux.
" https://github.com/tmux/tmux/issues/1246
" https://github.com/vim/vim/issues/993#issuecomment-255651605
if has("termguicolors")
  let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
  let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
  " Use 24-bit colors.
  set termguicolors
else
  " Using 256 colors.
  set t_Co=256
endif

" Abbrev of prompt.
set shortmess=aoOtTF

" Hide mouse pointer when type.
set mousehide

" Always show current position.
set ruler

" Always show the sign column, otherwise it would shift the text each time.
set signcolumn="number"

" " " Highlight chars when over 80 rows.
" " augroup vimrc_autocmds
" "   autocmd BufEnter * highlight OverLength ctermbg=red ctermfg=white guibg=red guifg=white
" "   autocmd BufEnter * match OverLength /\%81v.*/
" " augroup END

" Show command in the last line of screen.
set showcmd

" Height of the command bar.
set cmdheight=1

" Turn on the Wild menu.
" Enhance command-line completion.
set wildmenu
set wildmode=list:longest,full

" Ignore compiled files.
set wildignore=*.so,*.swp,*.pyc,*.pyo,*.exe,*.7z

if has("win16") || has("win32")
  set wildignore+=.git\*,.hg\*,.svn\*,*\desktop.ini
else
  set wildignore+=*/.git/*,*/.hg/*,*/.svn/*,*/.DS_Store
endif

" Minimal number of screen lines to keep above and below the cursor.
set scrolloff=5

" Vertical diffsplit.
set diffopt+=vertical

" Show matching brackets when text indicator is over them.
set showmatch

" How many tenths of a second to blink when matching brackets.
set matchtime=2

" Specify the behavior when switching between buffers.
set switchbuf=useopen
set showtabline=1
set tabpagemax=50

" 0 => never show.
" 1 => show only if there are at least two windows.
" 2 => always show.
set laststatus=2
set statusline=%<%f\ " filename
set statusline+=%w%h%m%r " option
set statusline+=\ [%{&ff}]/%y " fileformat/filetype
set statusline+=\ [%{getcwd()}] " current dir
set statusline+=\ [%{&encoding}] " encoding
set statusline+=%=%-14.(%l/%L,%c%V%)\ %p%% " Right aligned file nav info

" ColorScheme means to match keywords after loading a color scheme.
" Syntax means to match keywords when the `syntax` option has been set.
" More details can be checked by `:help autocmd`.
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

" Set to auto read when a file is changed from the outside.
set autoread

if &ttimeoutlen == -1
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

" " Swap files are necessary when crash recovery.
" " But I prefer to use DVCS to manange it.
" " Or just backup manually out of secure problem.
" set directory=$HOME/.vim/swapfiles//

" Turn persistent undo on,
" means that you can undo even when you close a buffer/VIM.
if has('persistent_undo')
  set undofile
  set undolevels=1000
  set undodir=$HOME/.vim/undotree
  augroup undo
    autocmd!
    autocmd BufWritePre /tmp/* setlocal noundofile
  augroup END
endif

" Tags config.
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

let mapleader = " "
let maplocalleader = ","

nnoremap <silent> <C-l> :<C-u>nohlsearch<C-R>=has('diff')?'<BAR>diffupdate':''<CR><CR>:syntax sync fromstart<CR><C-l>

nnoremap Y y$

" Fast saving.
nnoremap <silent> <localleader>w :write<CR>

" Fast quiting.
nnoremap <silent> <localleader>Q :qa<CR>

" Fast editing.
nnoremap <localleader>ee :e! .<CR>

" Edit macros.
nnoremap <localleader>em :<C-u><c-r><c-r>='let @'. v:register .' = '. string(getreg(v:register))<cr><c-f><left>

" Change CWD to current file.
nnoremap <localleader>cd :tcd %:h<CR>
nnoremap <localleader>dd :verbose pwd<CR>

" Exit terminal INSERT mode.
tnoremap jk <C-\><C-N>

" Make `&' keep the flags in substitute.
nnoremap & :&&<CR>
xnoremap & :&&<CR>

" Use `%%' to expand current file's dir.
cnoremap <expr> %% getcmdtype() == ':' ? expand('%:h').'/' : '%%'

" Make * and # work on visual mode too.
function! s:VSetSearch(cmdtype)
  let temp = @s
  norm! gv"sy
  let @/ = '\V' . substitute(escape(@s, a:cmdtype.'\'), '\n', '\\n', 'g')
  let @s = temp
endfunction

xnoremap * :<C-u>call <SID>VSetSearch('/')<CR>/<C-R>=@/<CR><CR>
xnoremap # :<C-u>call <SID>VSetSearch('?')<CR>?<C-R>=@/<CR><CR>

" Recursively vimgrep for word under cursor or selection if you hit
" leader-star.
if maparg('<leader>*', 'n') == ''
  nmap <leader>* :execute 'noautocmd vimgrep /\V' . substitute(escape(expand("<cword>"), '\'), '\n', '\\n', 'g') . '/ **'<CR>
endif
if maparg('<leader>*', 'v') == ''
  vmap <leader>* :<C-u>call <SID>VSetSearch()<CR>:execute 'noautocmd vimgrep /' . @/ . '/ **'<CR>
endif

" Buffer {{{

" Close current buffer
nnoremap <leader>bd :bp<Bar>bd #<CR>

" Close current buffer.
nnoremap <localleader>xx :bp<Bar>bd #<CR>

" Switch to prev buffer.
nnoremap <localleader>bb :e #<CR>

" Save buffer.
inoremap <C-x><C-s> :update<CR>
nnoremap <C-x><C-s> :update<CR>
vnoremap <C-x><C-s> :update<CR>

" }}} Buffer

" Window {{{

nnoremap <silent> <M-j> <C-W>j
nnoremap <silent> <M-k> <C-W>k
nnoremap <silent> <M-h> <C-W>h
nnoremap <silent> <M-l> <C-W>l

nnoremap <localleader>sq <C-w>q
nnoremap <localleader>sa <C-w>s
nnoremap <localleader>sd <C-w>v
nnoremap <localleader>oo <C-w>o
nnoremap <C-x>0 <C-w>q
nnoremap <C-x>1 <C-w>o
nnoremap <C-x>2 <C-w>s
nnoremap <C-x>3 <C-w>v
nnoremap <C-x>o <C-w><C-w>

" }}} Window

" Tab {{{

nnoremap <leader>tn :tabnew<CR>
nnoremap <leader>tx :tabclose<CR>
nnoremap <leader>tn :tabn<CR>
nnoremap <leader>tp :tabp<CR>
nnoremap <leader>tf :tabnew %<CR>
nnoremap <leader>tt :tab terminal<CR>

nnoremap <leader>th :tabmove -<CR>
nnoremap <leader>tl :tabmove +<CR>
nnoremap <leader>ta :tabmove 0<CR>
nnoremap <leader>te :tabmove $<CR>

" }}} Tab

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
  packadd! editexisting

else
  runtime macros/matchit.vim
  autocmd FileType python let b:match_words = '\<if\>:\<elif\>:\<else\>,'
        \ . '\<try\>:\<except\>'
  let b:match_ignorecase=0

  runtime macros/editexisting.vim

endif

" Load help doc
silent! helptags ALL

" }}} Package

" GUI Related {{{

if has('gui_running')
  " Cursor shape.
  set guicursor=n-v-sm:block
  set guicursor+=i-c-ci:ver25
  set guicursor+=ve-r-cr-o:hor20
  " No cursor blink.
  set guicursor+=a:blinkon0

  " Font.
  set guifont=LXGW\ WenKai\ Mono:h14

  " Change GUI relatives.
  command! Bigger  :let &guifont = substitute(&guifont, '\d\+$', '\=submatch(0)+1', '')
  command! Smaller :let &guifont = substitute(&guifont, '\d\+$', '\=submatch(0)-1', '')

  " Show table numbers.
  set guitablabel=%N:%M%t

  " Disables the GUI tab line in favor of the plain text version.
  set guioptions-=e
  " Disable scrollbars.
  set guioptions-=L
  set guioptions-=l
  set guioptions-=R
  set guioptions-=r
  " Disable toolbar.
  set guioptions-=T
endif

" }}} GUI Releated

" Plugin {{{

" Install vim-plug if not found
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
        \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
endif

" Run PlugInstall if there are missing plugins
autocmd VimEnter * if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
      \| PlugInstall --sync | source $MYVIMRC
      \| endif

call plug#begin()

" To specify a directory for plugins
"     call plug#begin('~/.vim/plugged')
" - Avoid using standard Vim directory names like 'plugin'
" Make sure you use single quotes

Plug 'LunarWatcher/auto-pairs'

Plug 'tpope/vim-abolish'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-obsession'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-rsi'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-unimpaired'

" git
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-fugitive'

" update &runtimepath and initialize plugin system
call plug#end()

" }}} Plugin
