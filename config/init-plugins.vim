" ###########################################################
" # File Name     : init-plugins.vim
" # Author        : Mou Tong
" # Email         : mou.tong@qq.com
" # Created Time  : 2018-01-26 08:00
" # Last Modified : 2020-10-29 10:30
" # By            : Mou Tong
" # Description   : plugins config for vim
" ###########################################################

" Plugin List {{{

" Specify a directory for plugins
" - Avoid using standard Vim directory names like 'plugin'
" Make sure you use single quotes

" Use plug.vim by default
if !exists('g:dalu_use_plug_manager') | let g:dalu_use_plug_manager = 1 | endif
if g:dalu_use_plug_manager
  if filereadable(expand("~/.vim/autoload/plug.vim"))

    call plug#begin('~/.vim/plugged')

    " better operation
    Plug 'Yggdroot/LeaderF', { 'do': './install.sh' }
    Plug 'Yggdroot/indentLine'
    Plug 'editorconfig/editorconfig-vim'
    Plug 'honza/vim-snippets'
    Plug 'liuchengxu/vim-which-key'
    Plug 'simnalamburt/vim-mundo'
    Plug 'vim-test/vim-test'

    Plug 'tpope/vim-abolish'
    Plug 'tpope/vim-commentary'
    Plug 'tpope/vim-dispatch'
    Plug 'tpope/vim-obsession'
    Plug 'tpope/vim-projectionist'
    Plug 'tpope/vim-rails'
    Plug 'tpope/vim-repeat'
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
    Plug 'mzlogin/vim-markdown-toc'
    if executable('latexmk')
      Plug 'lervag/vimtex'
    endif

    " Appearance
    Plug 'junegunn/goyo.vim'
    Plug 'junegunn/limelight.vim'

    Plug 'luochen1990/rainbow'
    Plug 'octol/vim-cpp-enhanced-highlight'
    Plug 'ryanoasis/vim-devicons'
    if version >= 800 || has('nvim')
      Plug 'itchyny/lightline.vim'
    else
      Plug 'tpope/vim-flagship'
    endif

    " ColorScheme
    Plug 'NLKNguyen/papercolor-theme'
    Plug 'arcticicestudio/nord-vim'
    Plug 'ayu-theme/ayu-vim'
    Plug 'cocopon/iceberg.vim'
    Plug 'dracula/vim'
    Plug 'jnurmine/zenburn'
    Plug 'joshdick/onedark.vim'
    Plug 'junegunn/seoul256.vim'
    Plug 'morhetz/gruvbox'
    Plug 'nanotech/jellybeans.vim'
    Plug 'overcache/NeoSolarized'
    Plug 'rakr/vim-one'
    Plug 'whatyouhide/vim-gotham'

    " Lsp Support
    if version >= 800 || has('nvim')
      Plug 'neoclide/coc.nvim', {'branch': 'release'}
    elseif version >= 703 && has('lua')
      Plug 'Shougo/deoplete.vim'
    endif


    call plug#end()

  else
    echo "WARNING: plug.vim undetected, now downloading...\n"
    silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
          \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  endif
endif

" }}} Plugin List

" Plugin Config {{{

if g:dalu_use_plug_manager && filereadable(expand("~/.vim/autoload/plug.vim"))

  " Plugin Config - colorscheme {{{

  " set background=dark
  " colorscheme NeoSolarized

  " colorscheme names that use to set color
  let g:mycolors = [
        \ 'NeoSolarized'   ,
        \ 'PaperColor'     ,
        \ 'ayu'            ,
        \ 'default'        ,
        \ 'dracula'        ,
        \ 'gotham'         ,
        \ 'gotham256'      ,
        \ 'gruvbox'        ,
        \ 'iceberg'        ,
        \ 'jellybeans'     ,
        \ 'monokai'        ,
        \ 'nord'           ,
        \ 'one'            ,
        \ 'onedark'        ,
        \ 'seoul256'       ,
        \ 'solarized'      ,
        \ 'tomorrow-night' ,
        \ 'zenburn'
        \ ]

  " SetColors {{{

  nnoremap <F8>   :call NextColor(1)<CR>
  nnoremap <S-F8> :call NextColor(-1)<CR>
  nnoremap <M-F8> :call NextColor(0)<CR>

  " }}} SetColors

  " }}} Plugin Config - colorscheme

  " Plugin Config - lightline.vim {{{

  if filereadable(expand("~/.vim/plugged/lightline.vim/plugin/lightline.vim"))

    " -- INSERT -- is unnecessary anymore
    set noshowmode

    let g:lightline = {
          \ 'colorscheme': 'minimal',
          \ 'active': {
          \   'left': [ [ 'mode', 'paste' ], [ 'cocstatus', 'readonly', 'file_name' ] ],
          \ },
          \ 'inactive': {
          \   'left': [ [ 'filename' ], ['split'] ],
          \ },
          \ 'tabline': {
          \ 'left': [ [ 'tabs' ] ],
          \ 'right': [ [ 'git' ] ],
          \ },
          \ 'component_function': {
          \   'cocstatus' : 'coc#status',
          \   'file_name' : 'LightlineFilename',
          \   'git'       : 'FugitiveHead',
          \   'split'     : 'LightlineSplitline',
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

    " Use autocmd to update lightline when using coc.nvim
    augroup my-plugin
      autocmd!
      autocmd User CocStatusChange,CocDiagnosticChange call lightline#update()
    augroup END

  endif

  " }}} Plugin Config - lightline.vim

  " Plugin Config - emmet-vim {{{

  if filereadable(expand("~/.vim/plugged/emmet-vim/plugin/emmet.vim"))

    let g:user_emmet_install_global = 0
    augroup my-plugin
      autocmd FileType html,xhtml,xml,css,scss,sass,less EmmetInstall
    augroup END
    let g:user_emmet_leader_key = ','

  endif

  " }}} Plugin Config - emmet-vim

  " Plugin Config - vimtex {{{

  if filereadable(expand("~/.vim/plugged/vimtex/autoload/vimtex.vim"))

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

  endif

  " }}} Plugin Config - vimtex

  " Plugin Config - vim-cpp-enhanced-highlight {{{

  if filereadable(expand("~/.vim/plugged/vim-cpp-enhanced-highlight/after/syntax/cpp.vim"))

    " 高亮类，成员函数，标准库和模板
    let g:cpp_class_scope_highlight = 1
    let g:cpp_member_variable_highlight = 1
    let g:cpp_concepts_highlight = 1
    let g:cpp_experimental_simple_template_highlight = 1

  endif

  " }}} Plugin Config - vim-cpp-enhanced-highlight

  " Plugin Config - Limelight && Goyo {{{

  if filereadable(expand("~/.vim/plugged/goyo.vim/plugin/goyo.vim"))
        \       && filereadable(expand("~/.vim/plugged/limelight.vim/plugin/limelight.vim"))

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

    augroup my-plugin
      autocmd! User GoyoEnter nested call <SID>goyo_enter()
      autocmd! User GoyoLeave nested call <SID>goyo_leave()
    augroup END

  endif

  " }}} Plugin Config - Limelight && Goyo

  " Plugin Config - LeaderF {{{

  if filereadable(expand("~/.vim/plugged/LeaderF.vim/plugin/LeaderF.vim"))

    " don't show the help in normal mode
    let g:Lf_HideHelp = 1
    let g:Lf_UseCache = 0
    let g:Lf_UseVersionControlTool = 0
    let g:Lf_IgnoreCurrentBufferName = 1
    " Show icons, icons are shown by default
    let g:Lf_ShowDevIcons = 1
    " popup mode
    let g:Lf_WindowPosition = 'popup'
    let g:Lf_PreviewInPopup = 1
    let g:Lf_PreviewResult = {'Function': 0, 'BufTag': 0 }

  endif

  " }}} Plugin Config - LeaderF

  " Plugin Config - fzf {{{

  if filereadable(expand("~/.vim/plugged/fzf.vim/plugin/fzf.vim"))

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

  endif

  " }}} Plugin Config - fzf

  " Plugin Config - undotree {{{

  if filereadable(expand("~/.vim/plugged/undotree/plugin/undotree.vim"))

    let g:undotree_SplitWidth         = 40
    let g:undotree_SetFocusWhenToggle = 1

  endif

  " }}} Plugin Config - undotree

  " Plugin Config - vim-textobj-user {{{

  if filereadable(expand("~/.vim/plugged/vim-textobj-user/autoload/textobj/user.vim"))

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

  endif

  " }}} Plugin Config - vim-textobj-user

  " Plugin Config - vim-easy-align {{{

  if filereadable(expand("~/.vim/plugged/vim-easy-align/plugin/easy_align.vim"))

    map <Leader>g :EasyAlign<Space>
    nmap ga <Plug>(EasyAlign)
    xmap ga <Plug>(EasyAlign)

  endif

  " }}} Plugin Config - vim-easy-align

  " " {{{ Plugin Config - vim-repeat

  " if filereadable(expand("~/.vim/plugged/vim-repeat/autoload/repeat.vim"))

  "   " add support to different plugins
  "   " silent! call repeat#set("\<Plug>MyWonderfulMap", v:count)

  " endif

  " " }}} Plugin Config - vim-repeat

  " Plugin Config - commentary {{{

  if filereadable(expand("~/.vim/plugged/vim-commentary/plugin/commentary.vim"))

    " add comment support for specific file type
    augroup my-plugin
      autocmd FileType apache setlocal commentstring=#\ %s
    augroup END

  endif

  " }}} Plugin Config - commentary

  " Plugin Config - vim-dispatch {{{

  if filereadable(expand("~/.vim/plugged/vim-dispatch/plugin/dispatch.vim"))

    let test#strategy = "dispatch"
    " @see https://github.com/tpope/vim-dispatch/issues/222#issuecomment-493273080
    if !empty($TMUX)
      set shellpipe=2>&1\|tee
    endif

  endif

  " }}} Plugin Config - vim-dispatch

  " Plugin Config - rainbow {{{

  if filereadable(expand("~/.vim/plugged/rainbow/autoload/rainbow.vim"))

    let g:rainbow_active = 1 " 0 if you want to enable it later via :RainbowToggle
    let g:rainbow_conf = {
          \ 'guifgs': ['royalblue3', 'darkorange3', 'seagreen3', 'firebrick'],
          \ 'ctermfgs': ['lightblue', 'lightyellow', 'lightcyan', 'lightmagenta'],
          \ 'operators': '_,_',
          \ 'parentheses': ['start=/(/ end=/)/ fold', 'start=/\[/ end=/\]/ fold', 'start=/{/ end=/}/ fold'],
          \ 'separately': {
          \     '*': {},
          \     'tex': {
          \         'parentheses': ['start=/(/ end=/)/', 'start=/\[/ end=/\]/'],
          \     },
          \     'lisp': {
          \         'guifgs': ['royalblue3', 'darkorange3', 'seagreen3', 'firebrick', 'darkorchid3'],
          \     },
          \     'vim': {
          \         'parentheses': ['start=/(/ end=/)/', 'start=/\[/ end=/\]/', 'start=/{/ end=/}/ fold', 'start=/(/ end=/)/ containedin=vimFuncBody', 'start=/\[/ end=/\]/ containedin=vimFuncBody', 'start=/{/ end=/}/ fold containedin=vimFuncBody'],
          \     },
          \     'html': {
          \         'parentheses': ['start=/\v\<((area|base|br|col|embed|hr|img|input|keygen|link|menuitem|meta|param|source|track|wbr)[ >])@!\z([-_:a-zA-Z0-9]+)(\s+[-_:a-zA-Z0-9]+(\=("[^"]*"|'."'".'[^'."'".']*'."'".'|[^ '."'".'"><=`]*))?)*\>/ end=#</\z1># fold'],
          \     },
          \     'css': 0,
          \ }
          \}

  endif

  " }}} Plugin Config - rainbow

  " Plugin Config - indentline {{{

  if filereadable(expand("~/.vim/plugged/indentLine/after/plugin/indentLine.vim"))

    " WARNING
    " do not use non-mono char, or cursor will be in wrong position
    let g:indentLine_char_list = ['|', '¦', '┆', '┊']
    " Set indent level
    let g:indentLine_indentLevel = 5
    " Disable when open specific file types
    let g:indentLine_fileTypeExclude = ['text', 'help', 'json', 'terminal', 'coc-explorer']
    " Make exclude work in neovim
    let g:indentLine_bufNameExclude = ['term:.*']

  endif

  " }}} Plugin Config - indentline

  " Plugin Config - editorconfig {{{

  if filereadable(expand("~/.vim/plugged/editorconfig-vim/plugin/editorconfig.vim"))

    " Excluded patterns
    let g:EditorConfig_exclude_patterns = ['fugitive://.*', 'scp://.*']

  endif

  " }}} Plugin Config - editorconfig

  " Plugin Config - async {{{

  if filereadable(expand("~/.vim/plugged/asyncrun.vim/plugin/asyncrun.vim"))

    " Set the height of window when run AsyncRun
    let g:asyncrun_open = 6
    " Identify the project root directory
    " If not in any these rootmarks put an empty .root in directory
    let g:asyncrun_rootmarks = ['.svn', '.git', '.root', '.project', '.hg', 'build.xml']
    " Set terminal position and style when set output=terminal
    let g:asynctasks_term_pos = 'bottom'
    " Set default global name of AsyncTask config
    let g:asynctasks_rtp_config = "tasks.toml"

  endif

  " }}} Plugin Config - async

  " Plugin Config - coc.nvim {{{

  if filereadable(expand("~/.vim/plugged/coc.nvim/plugin/coc.vim"))

    " Basic {{{

    " Don't pass messages to |ins-completion-menu|.
    set shortmess+=c

    " Always show the signcolumn, otherwise it would shift the text each time
    " diagnostics appear/become resolved.
    if has("patch-8.1.1564")
      " Recently vim can merge signcolumn and number column into one
      set signcolumn=number
    elseif has('nvim')
      set signcolumn=auto
    else
      set signcolumn=yes
    endif

    augroup mygroup
      autocmd!
      " Disable coc in specific filetype
      autocmd FileType text,markdown let b:coc_enabled = 0
      " Setup formatexpr specified filetype(s).
      autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
      " Update signature help on jump placeholder.
      autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
    augroup end

    " Add (Neo)Vim's native statusline support.
    " NOTE: Please see `:h coc-status` for integrations with external plugins that
    " provide custom statusline: lightline.vim, vim-airline.
    set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

    " }}} Basic

    " cocExtensions {{{

    let g:coc_global_extensions = [
          \ 'coc-bookmark'  ,
          \ 'coc-clangd'    ,
          \ 'coc-explorer'  ,
          \ 'coc-highlight' ,
          \ 'coc-json'      ,
          \ 'coc-lists'     ,
          \ 'coc-pairs'     ,
          \ 'coc-pyright'   ,
          \ 'coc-snippets'  ,
          \ ]

    " coc config - explorer {{{

    let g:coc_explorer_global_presets = {
          \   '.vim': {
          \      'root-uri': '~/.vim',
          \   },
          \   'floating': {
          \      'position': 'floating',
          \   },
          \   'floatingLeftside': {
          \      'position': 'floating',
          \      'floating-position': 'left-center',
          \      'floating-width': 50,
          \   },
          \   'floatingRightside': {
          \      'position': 'floating',
          \      'floating-position': 'left-center',
          \      'floating-width': 50,
          \   },
          \   'simplify': {
          \     'file.child.template': '[selection | clip | 1] [indent][icon | 1] [filename omitCenter 1]'
          \   }
          \ }

    " Hide the statusline when open coc-explorer
    augroup CocExplorerCustom
      autocmd!
      autocmd User CocExplorerOpenPost setlocal statusline=%#NonText#
    augroup END

    " }}} coc config - explorer

    " coc config - pairs {{{

    " disable characters for a specified filetype
    autocmd FileType vim let b:coc_pairs_disabled = ['"']

    " }}} coc config - pairs

    " coc config - snippets {{{

    let g:snips_author = "dalu"
    let g:snips_email  = "mou.tong@qq.com"
    let g:snips_about  = "dalu <mou.tong@qq.com>"
    let g:snips_github = "dalu98"

    " Use <M-l> for trigger snippet expand.
    imap <M-l> <Plug>(coc-snippets-expand)

    " Make <tab> for trigger completion
    inoremap <silent><expr> <TAB>
          \ pumvisible() ? coc#_select_confirm() :
          \ coc#expandableOrJumpable() ? "\<C-r>=coc#rpc#request('doKeymap', ['snippets-expand-jump',''])\<CR>" :
          \ <SID>check_back_space() ? "\<TAB>" :
          \ coc#refresh()

    function! s:check_back_space() abort
      let col = col('.') - 1
      return !col || getline('.')[col - 1]  =~# '\s'
    endfunction

    let g:coc_snippet_next = '<tab>'

    " }}} coc config - snippets

    " }}} cocExtensions

    " Command {{{

    " Add `:Format` command to format current buffer.
    command! -nargs=0 Format :call CocAction('format')
    " Add `:Fold` command to fold current buffer.
    command! -nargs=? Fold :call CocAction('fold', <f-args>)
    " Add `:OR` command for organize imports of the current buffer.
    command! -nargs=0 OR :call CocAction('runCommand', 'editor.action.organizeImport')

    " }}} Command

    " Keybindings {{{

    " multipleCursor {{{

    " Highlight the symbol and its references when holding the cursor.
    " autocmd CursorHold * silent call CocActionAsync('highlight')

    " see @ https://medium.com/@schtoeffel/you-don-t-need-more-than-one-cursor-in-vim-2c44117d51db
    " translate @ https://macplay.github.io/posts/vim-bu-xu-yao-duo-guang-biao-bian-ji-gong-neng/

    nmap <silent> gmp <Plug>(coc-cursors-position)
    nmap <silent> gmw <Plug>(coc-cursors-word)
    xmap <silent> gmw <Plug>(coc-cursors-range)
    nmap <silent> gmo <Plug>(coc-cursors-operator)
    nmap <silent> gmn <Plug>(coc-cursors-word)*
    xmap <silent> gmn <CR><CR>gN<Plug>(coc-cursors-range)gn

    " }}} multipleCursor

    " codeAction {{{

    " Applying codeAction to the selected region.
    " Example: `<leader>aap` for current paragraph
    xmap <leader>a  <Plug>(coc-codeaction-selected)
    nmap <leader>a  <Plug>(coc-codeaction-selected)

    " }}} codeAction

    " Completion {{{

    " Use tab for trigger completion with characters ahead and navigate.
    " NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
    " other plugin before putting this into your config.
    inoremap <silent><expr> <TAB>
          \ pumvisible() ? "\<C-n>" :
          \ <SID>check_back_space() ? "\<TAB>" :
          \ coc#refresh()
    inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

    function! s:check_back_space() abort
      let col = col('.') - 1
      return !col || getline('.')[col - 1]  =~# '\s'
    endfunction

    " Use <C-l> to trigger completion.
    inoremap <silent><expr> <C-l> coc#refresh()

    " Use <CR> to confirm completion, `<C-g>u` means break undo chain at current
    " position. Coc only does snippet and additional edit on confirm.
    if has('patch8.1.1068')
      " Use `complete_info` if your (Neo)Vim version supports it.
      inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"
    else
      imap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
    endif

    " }}} Completion

    " Documentation {{{

    " Use K to show documentation in preview window.
    nnoremap <silent> K :call <SID>show_documentation()<CR>

    function! s:show_documentation()
      if (index(['vim','help'], &filetype) >= 0)
        execute 'h '.expand('<cword>')
      else
        call CocAction('doHover')
      endif
    endfunction

    " }}} Documentation

    " textobj {{{

    " Map function and class text objects
    " NOTE: Requires textDocument.documentSymbol' support from the language
    " server.
    xmap if <Plug>(coc-funcobj-i)
    omap if <Plug>(coc-funcobj-i)
    xmap af <Plug>(coc-funcobj-a)
    omap af <Plug>(coc-funcobj-a)
    xmap ic <Plug>(coc-classobj-i)
    omap ic <Plug>(coc-classobj-i)
    xmap ac <Plug>(coc-classobj-a)
    omap ac <Plug>(coc-classobj-a)

    " Use <CTRL-S> for selections ranges.
    " Requires 'textDocument/selectionRange support of LS, ex: coc-tsserver
    nmap <silent> <C-s> <Plug>(coc-range-select)
    xmap <silent> <C-s> <Plug>(coc-range-select)

    " }}} textobj

    " Use `[w` and `]w` to navigate diagnostics
    nmap <silent> [w <Plug>(coc-diagnostic-prev)
    nmap <silent> ]w <Plug>(coc-diagnostic-next)

    " Formatting selected code.
    xmap <leader>ef  <Plug>(coc-format-selected)

    " }}} Keybindings

  endif

  " }}} Plugin Config - coc.nvim

  " Plugin Config - deoplete {{{

  if filereadable(expand("~/.vim/plugged/deoplete.nvim/plugin/deoplete.vim"))
  endif

  " }}} Plugin Config - deoplete

  " Plugin Config - vim-which-key {{{

  if filereadable(expand("~/.vim/plugged/vim-which-key/plugin/which_key.vim"))

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
          \ '?' : [':CocList buffers' , 'list-buffers']    ,
          \ }

    let g:which_key_map['c'] = {
          \ 'name' : '+code' ,
          \ 'A' : ['<Plug>(coc-codeaction)'   , 'apply-codeAction-buffer'] ,
          \ 'C' : [':AsyncTask file-build'    , 'build-current-file']      ,
          \ 'F' : [':Format'                  , 'format-current-buffer']   ,
          \ 'P' : [':AsyncTask project-build' , 'builid-current-project']  ,
          \ 'R' : ['<Plug>(coc-refactor)'     , 'refactor']                ,
          \ 'c' : [':AsyncTask file-run'      , 'run-current-file']        ,
          \ 'f' : ['<Plug>(coc-fix-current)'  , 'autofix-current-buffer']  ,
          \ 'p' : [':AsyncTask project-run'   , 'run-current-project']     ,
          \ 'r' : ['<Plug>(coc-rename)'       , 'symbol-rename']           ,
          \ 'g' : {
          \ 'name' : '+goto' ,
          \ 'd' : ['<Plug>(coc-definition)'      , 'definition']      ,
          \ 'r' : ['<Plug>(coc-references)'      , 'references']      ,
          \ 't' : ['<Plug>(coc-type-definition)' , 'type-definition'] ,
          \ 'i' : ['<Plug>(coc-implementation)'  , 'implementation']  ,
          \ '[' : ['<Plug>(coc-diagnostic-prev)' , 'prev error']      ,
          \ ']' : ['<Plug>(coc-diagnostic-next)' , 'next error']      ,
          \ } ,
          \ }

    let g:which_key_map['C'] = {
          \ 'name' : '+coc-list' ,
          \ 'C' : [':CocConfig'           , 'edit-CocConfig']           ,
          \ 'D' : [':CocDisable'          , 'coc-disable']              ,
          \ 'E' : [':CocEnable'           , 'coc-enable']               ,
          \ 'R' : [':CocRestart'          , 'restart-coc']              ,
          \ 'a' : [':CocList diagnostics' , 'show-diagnostics']         ,
          \ 'c' : [':CocList commands'    , 'show-commands']            ,
          \ 'e' : [':CocList extensions'  , 'show-extensions']          ,
          \ 'j' : [':CocNext'             , 'action-for-next-item']     ,
          \ 'k' : [':CocPrev'             , 'action-for-prev-item']     ,
          \ 'o' : [':CocList outline'     , 'find-current-symbol']      ,
          \ 'p' : [':CocListResume'       , 'resume-latest-coc-list']   ,
          \ 's' : [':CocList -I symbols'  , 'search-workspace-symbols'] ,
          \ 'b' : {
          \ 'name' : '+bookmark' ,
          \ 'b' : [':CocList bookmark'             , 'open-bookmark']     ,
          \ 'n' : ['<Plug>(coc-bookmark-next)'     , 'next-bookmark']     ,
          \ 'p' : ['<Plug>(coc-bookmark-prev)'     , 'prev-bookmark']     ,
          \ 't' : ['<Plug>(coc-bookmark-toggle)'   , 'toggle-bookmark']   ,
          \ 'a' : ['<Plug>(coc-bookmark-annotate)' , 'annotate-bookmark'] ,
          \ } ,
          \ }

    let g:which_key_map['f'] = {
          \ 'name' : '+file' ,
          \ 'R' : [':Revert'              , 'revert-fileencoding'] ,
          \ 'c' : [':e ~/.vim/config'     , 'edit-config']         ,
          \ 'e' : [':CocCommand explorer' , 'coc-explorer']        ,
          \ 's' : ['update'               , 'save-file']           ,
          \ 'S' : ['Files'                , 'search-file']         ,
          \ 'g' : [':Goyo'                , 'Goyo']                ,
          \ 'o' : ['<Plug>(coc-openlink)' , 'open-link']           ,
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
          \ 'q' : [':Obsession | qa!'    , 'quit-vim-without-saving'] ,
          \ 'Q' : [':qa!'                , 'quit-vim-without-saving'] ,
          \ 'l' : [':call LoadSession()' , 'restore-last-session']    ,
          \ 'L' : [':Obsession!'         , 'toggle-session']          ,
          \ 's' : ['Obsession'           , 'save-current-session']    ,
          \ }

    let g:which_key_map['s'] = {
          \ 'name' : '+search' ,
          \ 'b' : ['LeaderfBuffer'          , 'search-buffer']        ,
          \ 'f' : ['LeaderfFile'            , 'search-file']          ,
          \ 'F' : [':FZF'                   , 'search-file-fzf']      ,
          \ 'h' : [':CocList searchhistory' , 'search-history']       ,
          \ 'd' : [':Leaderf rg'            , 'search-cwd']           ,
          \ 's' : [':CocList lines'         , 'search-buffer']        ,
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
          \ '?' : [':CocList windows'  , 'window']              ,
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

  endif

  " }}} Plugin Config - vim-which-key

endif

" }}} Plugin Config

" minpac config {{{

if has('packages')

  packadd minpac

  if !exists('g:loaded_minpac')
    echo "WARNING: minpac undetected, now downloading...\n"
    silent !git clone --depth 1 -- https://github.com/k-takata/minpac.git
          \ ~/.vim/pack/minpac/opt/minpac
  else
    " minpac is available.
    call minpac#init()
    call minpac#add('k-takata/minpac', {'type': 'opt'})

    " Additional plugins here.
    call minpac#add('vim/killersheep', {'type': 'opt'})

    call minpac#add('vimwiki/vimwiki')
    let g:vimwiki_list = [{'path': '~/.vim/vimwiki/',
          \ 'path_html': '~/.vim/vimwiki_html/'}]

    call minpac#add('tpope/vim-repeat', {'type': 'opt'})
    call minpac#add('tpope/vim-flagship', {'type': 'opt'})
    call minpac#add('tpope/vim-surround', {'type': 'opt'})
    call minpac#add('tpope/vim-unimpaired', {'type': 'opt'})
    call minpac#add('tpope/vim-commentary', {'type': 'opt'})

  endif

  command! PackUpdate call minpac#update()
  command! PackStatus call minpac#status()
  command! PackClean  call minpac#clean()

endif

" }}} minpac config
