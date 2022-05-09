" Plugin List {{{

" Specify a directory for plugins
" - Avoid using standard Vim directory names like 'plugin'
" Make sure you use single quotes

" reuse plug.vim
if plug#begin('~/.vim/plugged')

  " better operation
  Plug 'Yggdroot/LeaderF', { 'do': ':LeaderfInstallCExtension' }
  Plug 'Yggdroot/indentLine'
  Plug 'editorconfig/editorconfig-vim'
  Plug 'honza/vim-snippets'
  Plug 'liuchengxu/vim-which-key'
  Plug 'simnalamburt/vim-mundo'
  Plug 'vim-test/vim-test'
  Plug 'LunarWatcher/auto-pairs'

  Plug 'tpope/vim-abolish'
  Plug 'tpope/vim-commentary'
  Plug 'tpope/vim-dispatch'
  Plug 'tpope/vim-obsession'
  Plug 'tpope/vim-projectionist'
  Plug 'tpope/vim-rails'
  Plug 'tpope/vim-repeat'
  Plug 'tpope/vim-rsi'
  Plug 'tpope/vim-surround'
  Plug 'tpope/vim-unimpaired'

  Plug 'junegunn/fzf', { 'do': { -> fzf#install() } } | Plug 'junegunn/fzf.vim'

  Plug 'skywind3000/asyncrun.vim'
  Plug 'skywind3000/asynctasks.vim'

  " textobj
  Plug 'easymotion/vim-easymotion'
  Plug 'junegunn/vim-easy-align'
  Plug 'kana/vim-textobj-user'
  Plug 'wellle/targets.vim'

  " git
  Plug 'airblade/vim-gitgutter'
  Plug 'tpope/vim-fugitive'

  " language
  Plug 'mattn/emmet-vim'
  Plug 'pangloss/vim-javascript'
  Plug 'mzlogin/vim-markdown-toc'
  if executable('latexmk')
    Plug 'lervag/vimtex'
  endif

  " Appearance
  Plug 'junegunn/goyo.vim'
  Plug 'junegunn/limelight.vim'

  Plug 'luochen1990/rainbow'
  Plug 'octol/vim-cpp-enhanced-highlight'
  Plug 'itchyny/lightline.vim'

  " ColorScheme
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

  " misc
  Plug 'vimwiki/vimwiki'
  Plug 'vim/killersheep', { 'dir': '~/.vim/pack/mine/opt/killersheep' }

  call plug#end()
else
  echo "WARNING: plug.vim undetected, now downloading...\n"
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
        \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
endif

" }}} Plugin List

" Plugin Config {{{

" lightline.vim {{{

" -- INSERT -- is unnecessary anymore
set noshowmode

let g:lightline = {
      \ 'colorscheme': 'minimal',
      \ 'active': {
        \ 'left': [
          \ [ 'mode', 'paste' ],
          \ [ 'readonly', 'file_name' ]
        \ ],
      \ },
      \ 'inactive': {
        \ 'left': [ [ 'filename' ], ['split'] ],
      \ },
      \ 'tabline': {
        \ 'left': [ [ 'tabs' ] ],
        \ 'right': [ [ 'git' ] ],
      \ },
      \ 'component_function': {
        \ 'file_name' : 'LightlineFilename',
        \ 'git'       : 'FugitiveHead',
        \ 'split'     : 'LightlineSplitline',
      \ },
    \ }

" file_name {{{

function! LightlineFilename()
  let filename = expand('%:t') !=# '' ? expand('%:t') : '[No Name]'
  let modified = &filetype =~# 'help\|vimfiler' ? '' : &modified ? ' +' : &modifiable ? '' : ' -'
  return filename . modified
endfunction

" }}} file_name

" split {{{

function! LightlineSplitline()
  let split = '*****'
  let inactive = 'INACTIVE'
  return split . inactive . split
endfunction

" }}} split

" }}} lightline.vim

" emmet-vim {{{

let g:user_emmet_install_global = 0
autocmd FileType html,xhtml,xml,css,scss,sass,less,vue,javascript,javascriptreact EmmetInstall
let g:user_emmet_leader_key = '<C-y>'

" }}} emmet-vim

" vimtex {{{

let g:tex_flavor = 'xelatex'
let g:vimtex_compiler_latexmk = {
      \ 'options' : [
        \   '-xelatex',
        \   '-shell-escape',
        \   '-verbose',
        \   '-file-line-error',
        \   '-synctex=1',
        \   '-interaction=nonstopmode',
        \ ],
        \ }

" add compiler callback for neovim
if has('nvim')
  let g:vimtex_compiler_progname = 'nvr'
endif

" vimtex configuration for neocomplete
if exists('g:loaded_neocomplete')
  if !exists('g:neocomplete#sources#omni#input_patterns')
    let g:neocomplete#sources#omni#input_patterns = {}
  endif
  let g:neocomplete#sources#omni#input_patterns.tex =
        \ g:vimtex#re#neocomplete
endif

" }}} vimtex

" vim-cpp-enhanced-highlight {{{

" 高亮类，成员函数，标准库和模板
let g:cpp_class_scope_highlight = 1
let g:cpp_member_variable_highlight = 1
let g:cpp_concepts_highlight = 1
let g:cpp_experimental_simple_template_highlight = 1

" }}} vim-cpp-enhanced-highlight

" Limelight && Goyo {{{

nmap <silent> <C-w><Enter> :Limelight!!<CR>
let g:limelight_conceal_ctermfg     = 250
let g:limelight_default_coefficient = 0.8

function! s:goyo_enter()
  let b:fcstatus = &foldcolumn
  setlocal foldcolumn=0
  set noshowmode
  set noshowcmd
  set scrolloff=999
  Limelight
endfunction

function! s:goyo_leave()
  let &foldcolumn = b:fcstatus
  set showmode
  set showcmd
  set scrolloff=3
  Limelight!
endfunction

augroup myplugin
  autocmd! User GoyoEnter nested call <SID>goyo_enter()
  autocmd! User GoyoLeave nested call <SID>goyo_leave()
augroup END

" }}} Limelight && Goyo

" LeaderF {{{

" popup mode
if (version >= 801 && has('popupwin')) || (has('nvim') && has('float'))
  let g:Lf_WindowPosition = 'popup'
  let g:Lf_PreviewInPopup = 1
endif

let g:Lf_ShortcutF = "<leader>ff"
noremap <leader>fb :<C-U><C-R>=printf("Leaderf buffer %s", "")<CR><CR>
noremap <leader>fm :<C-U><C-R>=printf("Leaderf mru %s", "")<CR><CR>
noremap <leader>ft :<C-U><C-R>=printf("Leaderf bufTag %s", "")<CR><CR>
noremap <leader>fl :<C-U><C-R>=printf("Leaderf line %s", "")<CR><CR>

" TAGS
let g:Lf_GtagsAutoGenerate = 1
let g:Lf_Gtagslabel = 'native-pygments'
let g:Lf_RootMarkers = ['.git', '.hg', '.svn', '.projectile', '.project']
noremap <leader>fg :<C-U><C-R>=printf("Leaderf! gtags --update")<CR><CR>
noremap <leader>fc :<C-U><C-R>=printf("Leaderf! gtags --by-context --auto-jump")<CR><CR>
noremap <leader>fr :<C-U><C-R>=printf("Leaderf! gtags -r %s --auto-jump", expand("<cword>"))<CR><CR>
noremap <leader>fd :<C-U><C-R>=printf("Leaderf! gtags -d %s --auto-jump", expand("<cword>"))<CR><CR>
noremap <leader>fo :<C-U><C-R>=printf("Leaderf! gtags --recall %s", "")<CR><CR>
noremap <leader>fT :<C-U><C-R>=printf("Leaderf gtags %s", "")<CR><CR>
noremap <leader>fn :<C-U><C-R>=printf("Leaderf gtags --next %s", "")<CR><CR>
noremap <leader>fp :<C-U><C-R>=printf("Leaderf gtags --previous %s", "")<CR><CR>

" misc
let g:Lf_ShowDevIcons = 0

" }}} LeaderF

" fzf {{{

nnoremap <Leader>p :<C-u>FZF<CR>

" This is the default extra key bindings
let g:fzf_action = {
      \ 'ctrl-t': 'tab split',
      \ 'ctrl-x': 'split',
      \ 'ctrl-v': 'vsplit'
      \ }

" An action can be a reference to a function that processes selected lines
function! s:build_quickfix_list(lines)
  call setqflist(map(copy(a:lines), '{ "filename": v:val }'))
  copen
  cc
endfunction

let g:fzf_action = {
      \ 'ctrl-q': function('s:build_quickfix_list'),
      \ 'ctrl-t': 'tab split',
      \ 'ctrl-x': 'split',
      \ 'ctrl-v': 'vsplit'
      \ }

" Default fzf layout
" - down / up / left / right
let g:fzf_layout = { 'down': '~40%' }

" You can set up fzf window using a Vim command (Neovim or latest Vim 8 required)
let g:fzf_layout = { 'window': 'enew' }
let g:fzf_layout = { 'window': '-tabnew' }
let g:fzf_layout = { 'window': '10new' }

" Customize fzf colors to match your color scheme
" - fzf#wrap translates this to a set of `--color` options
let g:fzf_colors = {
      \ 'fg':      ['fg', 'Normal'],
      \ 'bg':      ['bg', 'Normal'],
      \ 'hl':      ['fg', 'Comment'],
      \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
      \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
      \ 'hl+':     ['fg', 'Statement'],
      \ 'info':    ['fg', 'PreProc'],
      \ 'border':  ['fg', 'Ignore'],
      \ 'prompt':  ['fg', 'Conditional'],
      \ 'pointer': ['fg', 'Exception'],
      \ 'marker':  ['fg', 'Keyword'],
      \ 'spinner': ['fg', 'Label'],
      \ 'header':  ['fg', 'Comment']
      \ }

" Enable per-command history
" - History files will be stored in the specified directory
" - When set, CTRL-N and CTRL-P will be bound to 'next-history' and
"   'previous-history' instead of 'down' and 'up'.
let g:fzf_history_dir = '~/.local/share/fzf-history'

" }}} fzf

" undotree {{{

let g:undotree_SplitWidth         = 40
let g:undotree_SetFocusWhenToggle = 1

" }}} undotree

" vim-textobj-user {{{

call textobj#user#plugin('braces', {
      \   'angle': {
        \     'pattern': ['<<', '>>'],
        \     'select-a': 'aA',
        \     'select-i': 'iA',
        \   },
        \ })

call textobj#user#plugin('entire', {
      \      '-': {
        \        'select-a': 'ae',  'select-a-function': 'CurrentBufferA',
        \        'select-i': 'ie',  'select-i-function': 'CurrentBufferI'
        \      },
        \    })

function! CurrentBufferA()
  normal! m'
  keepjumps normal! gg0
  let start_pos = getpos('.')
  keepjumps normal! G$
  let end_pos = getpos('.')
  return ['V', start_pos, end_pos]
endfunction

function! CurrentBufferI()
  normal! m'
  keepjumps normal! gg0
  call search('^.', 'cW')
  let start_pos = getpos('.')
  keepjumps normal! G$
  call search('^.', 'bcW')
  normal! $
  let end_pos = getpos('.')
  return ['V', start_pos, end_pos]
endfunction

call textobj#user#plugin('line', {
      \   '-': {
        \     'select-a-function': 'CurrentLineA',
        \     'select-a': 'al',
        \     'select-i-function': 'CurrentLineI',
        \     'select-i': 'il',
        \   },
        \ })

function! CurrentLineA()
  normal! 0
  let head_pos = getpos('.')
  normal! $
  let tail_pos = getpos('.')
  return ['v', head_pos, tail_pos]
endfunction

function! CurrentLineI()
  normal! ^
  let head_pos = getpos('.')
  normal! g_
  let tail_pos = getpos('.')
  let non_blank_char_exists_p = getline('.')[head_pos[2] - 1] !~# '\s'
  return
        \ non_blank_char_exists_p
        \ ? ['v', head_pos, tail_pos]
        \ : 0
endfunction

call textobj#user#plugin('tex', {
      \   'paren-math': {
        \     'pattern': ['\\left(', '\\right)'],
        \     'select-a': [],
        \     'select-i': [],
        \   },
        \ })

augroup tex_textobjs
  autocmd!
  autocmd FileType tex call textobj#user#map('tex', {
        \   'paren-math': {
          \     'select-a': '<buffer> a(',
          \     'select-i': '<buffer> i(',
          \   },
          \ })
augroup END

" }}} vim-textobj-user

" vim-easy-align {{{

map <Leader>g :EasyAlign<Space>
nmap ga <Plug>(EasyAlign)
xmap ga <Plug>(EasyAlign)

" }}} vim-easy-align

" vim-dispatch {{{

let test#strategy = "dispatch"
" https://github.com/tpope/vim-dispatch/issues/222#issuecomment-493273080
if !empty($TMUX)
  set shellpipe=2>&1\|tee
endif

" }}} vim-dispatch

" vim-commentary {{{

nmap <leader>c <Plug>Commentary<CR>
xmap <leader>c <Plug>Commentary<CR>
omap <leader>c <Plug>Commentary<CR>
nmap <leader>cc <Plug>CommentaryLine

autocmd FileType apache setlocal commentstring=#\ %s

" }}} vim-commentary

" rainbow {{{

let g:rainbow_active = 1 " 0 if you want to enable it later via :RainbowToggle
let g:rainbow_conf = {
      \ 'guifgs': ['royalblue3', 'darkorange3', 'seagreen3', 'firebrick'],
      \ 'ctermfgs': ['lightblue', 'lightyellow', 'lightcyan', 'lightmagenta'],
      \ 'operators': '_,_',
      \ 'parentheses': ['start=/(/ end=/)/ fold', 'start=/\[/ end=/\]/ fold', 'start=/{/ end=/}/ fold'],
      \ 'separately': {
        \     '*': {},
        \     'tex': { 'parentheses': ['start=/(/ end=/)/', 'start=/\[/ end=/\]/'], },
        \     'lisp': { 'guifgs': ['royalblue3', 'darkorange3', 'seagreen3', 'firebrick', 'darkorchid3'], },
        \     'vim': { 'parentheses': ['start=/(/ end=/)/', 'start=/\[/ end=/\]/', 'start=/{/ end=/}/ fold', 'start=/(/ end=/)/ containedin=vimFuncBody', 'start=/\[/ end=/\]/ containedin=vimFuncBody', 'start=/{/ end=/}/ fold containedin=vimFuncBody'], },
        \     'html': { 'parentheses': ['start=/\v\<((area|base|br|col|embed|hr|img|input|keygen|link|menuitem|meta|param|source|track|wbr)[ >])@!\z([-_:a-zA-Z0-9]+)(\s+[-_:a-zA-Z0-9]+(\=("[^"]*"|'."'".'[^'."'".']*'."'".'|[^ '."'".'"><=`]*))?)*\>/ end=#</\z1># fold'], },
        \     'css': 0,
        \ }
        \}

" }}} rainbow

" indentline {{{

" WARNING
" do not use non-mono char, or cursor will be in wrong position
let g:indentLine_char_list = ['|', '¦', '┆', '┊']
" Set indent level
let g:indentLine_indentLevel = 5
" Disable when open specific file types
let g:indentLine_fileTypeExclude = ['text', 'help', 'json', 'terminal']
" Make exclude work in neovim
let g:indentLine_bufNameExclude = ['term:.*']

" }}} indentline

" editorconfig {{{

" Excluded patterns
let g:EditorConfig_exclude_patterns = ['fugitive://.*', 'scp://.*']

" }}} editorconfig

" async{run,task} {{{

" Set the height of window when run AsyncRun
let g:asyncrun_open = 6
" Identify the project root directory
" If not in any these rootmarks put an empty .root in directory
let g:asyncrun_rootmarks = ['.svn', '.git', '.root', '.project', '.hg', 'build.xml']
" Set terminal position and style when set output=terminal
let g:asynctasks_term_pos = 'bottom'
" Set default global name of AsyncTask config
let g:asynctasks_rtp_config = "tasks.toml"

" }}} async{run,task}

" vimwiki {{{

let g:vimwiki_list = [{'path': '~/wiki/',
      \ 'path_html': '~/wiki/vimwiki_html/'}]

" }}} vimwiki

" vim-which-key {{{

" By default timeoutlen is 1000 ms
" Use default leader key bindings when not popup
set timeoutlen=1000

let g:mapleader = ','
let g:maplocalleader = ' '
nnoremap <silent> <leader>      :<c-u>WhichKey ','<CR>
nnoremap <silent> <localleader> :<c-u>WhichKey ' '<CR>

" Define prefix dictionary
let g:which_key_map =  {}

" Second level dictionaries
" `name' is a special field. It will define the name of the group,
" e.g., leader-f is the "+file" group.
" Unnamed groups will show a default empty string "+prefix".

" =======================================================
" Create menus based on existing mappings
" =======================================================
" You can pass a descriptive text to an existing mapping.

let g:which_key_map['*'] = 'enhanced *'
let g:which_key_map['e'] = {
      \ 'name' : '+edit' ,
      \ 'c' : 'edit-config'   ,
      \ 'f' : 'format-selected-region' ,
      \ 'r' : 'reload-config' ,
      \ 'm' : 'edit-macros'
      \ }

" =======================================================
" Create menus not based on existing mappings:
" =======================================================
" Provide commands(ex-command, <Plug>/<C-W>/<C-d> mapping, etc.) and
" descriptions for existing mappings

let g:which_key_map['b'] = {
      \ 'name' : '+buffer' ,
      \ 'd' : ['bd'               , 'delete-buffer']   ,
      \ 'f' : ['bfirst'           , 'first-buffer']    ,
      \ 'l' : ['blast'            , 'last-buffer']     ,
      \ 'n' : ['bnext'            , 'next-buffer']     ,
      \ 'p' : ['bprevious'        , 'previous-buffer'] ,
      \ }

let g:which_key_map['c'] = {
      \ 'name' : '+code' ,
      \ 'B' : [':AsyncTask project-build' , 'build-current-project']   ,
      \ 'C' : [':AsyncTask project-run'   , 'run-current-project']     ,
      \ 'F' : [':Format'                  , 'format-current-buffer']   ,
      \ 'P' : [':AsyncTask project-build' , 'build-current-project']   ,
      \ 'b' : [':AsyncTask file-build'    , 'build-current-file']      ,
      \ 'c' : [':AsyncTask file-run'      , 'run-current-file']        ,
      \ }

let g:which_key_map['f'] = {
      \ 'name' : '+file' ,
      \ 'R' : [':Revert'              , 'revert-fileencoding'] ,
      \ 's' : ['update'               , 'save-file']           ,
      \ 'S' : ['Files'                , 'search-file']         ,
      \ 'g' : [':Goyo'                , 'Goyo']                ,
      \ 'p' : [':e ~/.vim/snippets'   , 'edit-snippets']       ,
      \ 'r' : [':source ~/.vimrc'     , 'reload-config']       ,
      \ 'u' : ['UndotreeToggle'       , 'undo-tree']           ,
      \ }

let g:which_key_map['g'] = {
      \ 'name' : '+git' ,
      \ 'g' : [':Gstatus' , 'git-status'],
      \ }

let g:which_key_map['l'] = {
      \ 'name' : '+load' ,
      \ 't' : [':Colors' , 'load-theme'],
      \ }

let g:which_key_map['q'] = {
      \ 'name' : '+quit/session' ,
      \ 'q' : [':Obsession | qa!'    , 'quit-vim-with-saving-session'] ,
      \ 'Q' : [':qa!'                , 'quit-vim-without-asking']      ,
      \ 'l' : [':call LoadSession()' , 'restore-last-session']         ,
      \ 'L' : [':Obsession!'         , 'toggle-session']               ,
      \ 's' : ['Obsession'           , 'save-current-session']         ,
      \ }

let g:which_key_map['s'] = {
      \ 'name' : '+search' ,
      \ 'b' : ['LeaderfBuffer'          , 'search-buffer']        ,
      \ 'f' : ['LeaderfFile'            , 'search-file']          ,
      \ 'F' : [':FZF'                   , 'search-file-fzf']      ,
      \ 'd' : [':Leaderf rg'            , 'search-cwd']           ,
      \ 'm' : ['LeaderfMru'             , 'search-rencent-files'] ,
      \ }

let g:which_key_map['t'] = {
      \ 'name' : '+tabs' ,
      \ 'a' : ['tabnew'      , 'add-tab']      ,
      \ 'd' : ['tabclose'    , 'delete-tab']   ,
      \ 'h' : ['tabfirst'    , 'first-tab']    ,
      \ 'l' : ['tablast'     , 'last-tab']     ,
      \ 'n' : ['tabnext'     , 'next-tab']     ,
      \ 'p' : ['tabprevious' , 'previous-tab'] ,
      \ '?' : ['tabs'        , 'list-tabs']    ,
      \ }

let g:which_key_map['w'] = {
      \ 'name' : '+windows' ,
      \ '=' : ['<C-W>='            , 'balance-window']      ,
      \ 'H' : ['<C-W>5<'           , 'expand-window-left']  ,
      \ 'J' : ['resize +5'         , 'expand-window-below'] ,
      \ 'K' : ['resize -5'         , 'expand-window-up']    ,
      \ 'L' : ['<C-W>5>'           , 'expand-window-right'] ,
      \ 'c' : ['ClearBackground'   , 'clear-bg']            ,
      \ 'd' : ['<C-W>c'            , 'delete-window']       ,
      \ 'h' : ['<C-W>h'            , 'window-left']         ,
      \ 'j' : ['<C-W>j'            , 'window-below']        ,
      \ 'k' : ['<C-W>k'            , 'window-up']           ,
      \ 'l' : ['<C-W>l'            , 'window-right']        ,
      \ 's' : ['<C-W>s'            , 'split-window-below']  ,
      \ 'o' : ['<C-W>o'            , 'one-window-only']     ,
      \ 't' : ['TransparentToggle' , 'toggle-background']   ,
      \ 'v' : ['<C-W>v'            , 'split-window-right']  ,
      \ 'w' : ['<C-W>w'            , 'other-window']        ,
      \ 'q' : [':call asyncrun#quickfix_toggle(6)' , 'toggle-quickfix'] ,
      \ }

" Remind other key
nnoremap <silent> ] :<C-U>WhichKey ']'<CR>
nnoremap <silent> [ :<C-U>WhichKey '['<CR>

" Register key-value dict
call which_key#register(',' , "g:which_key_map")
call which_key#register(' ' , "g:which_key_map")

" }}} vim-which-key

" }}} Plugin Config
