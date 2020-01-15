""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                   => vim-plug的配置信息 <=
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

call plug#begin('~/.vim/plugged')

" 以下范例用来支持不同格式的插件安装.
" 请将安装插件的命令放在plug#begin和plug#end之间.

" Make sure you use single quotes

" Shorthand notation; fetches https://github.com/junegunn/vim-easy-align
"Plug 'junegunn/vim-easy-align'

" Any valid git URL is allowed
"Plug 'https://github.com/junegunn/vim-github-dashboard.git'

" Multiple Plug commands can be written in a single line using | separators
"Plug 'SirVer/ultisnips' | Plug 'honza/vim-snippets'

" Using a non-master branch
"Plug 'rdnetto/YCM-Generator', { 'branch': 'stable' }

" Using a tagged release; wildcard allowed (requires git 1.9.2 or above)
"Plug 'fatih/vim-go', { 'tag': '*' }

" Plugin options
"Plug 'nsf/gocode', { 'tag': 'v.20150303', 'rtp': 'vim' }

" Plugin outside ~/.vim/plugged with post-update hook
"Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }

" Unmanaged plugin (manually installed and updated)
"Plug '~/my-prototype-plugin'

"托管在Github上的插件
" 格式为 Plug '用户名/插件仓库名'
Plug 'junegunn/vim-plug'

Plug 'w0rp/ale'
Plug 'mhinz/vim-signify'
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
"Plug 'Valloric/YouCompleteMe'
Plug 'octol/vim-cpp-enhanced-highlight'

Plug 'tpope/vim-fugitive'
Plug 'Yggdroot/indentLine'
Plug 'airblade/vim-gitgutter'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'terryma/vim-multiple-cursors'

Plug 'kana/vim-textobj-user'
Plug 'kana/vim-textobj-indent'
Plug 'kana/vim-textobj-syntax'
Plug 'sgur/vim-textobj-parameter'

Plug 'flazz/vim-colorschemes'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'chriskempson/base16-vim'
Plug 'luochen1990/rainbow'

"Plug 'Raimondi/delimitMate'
"Plug 'universal-ctags/ctags'
"Plug 'scrooloose/nerdcommenter'
"Plug 'ludovicchabant/vim-gutentags'


" 由Git支持但不在github上的插件仓库 Plug 'git clone 后面的地址'


" 延迟按需加载，使用到命令的时候再加载或者打开对应文件类型才加载
" On-demand loading
Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
Plug 'tpope/vim-fireplace', { 'for': 'clojure' }
Plug 'kana/vim-textobj-function', { 'for':['c', 'cpp', 'vim', 'java'] }

" 在这行前添加你的插件
call plug#end()            " required

"
" 以下是常用命令
" :PlugInstall [name ...] [#threads] - Install plugins
" :PlugUpdate [name ...] [#threads]  - Install or update plugins
" :PlugClean[!]   - Remove unused directories (bang version will clean without prompt)
" :PlugUpgrade    - Upgrade vim-plug itself
" :PlugStatus     - Check the status of plugins
" :PlugDiff       - Examine changes from the previous update and the pending changes
" :PlugSnapshot[!] [output path]     - Generate script for restoring the current snapshot of the plugins
"
" 在该行后添加自己的配置信息




""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"              => airline configurations <=                "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:airline_theme='base16'
let g:airline_powerline_fonts = 1
"let g:airline_solarized_bg='dark' " enable this when use solarized theme

let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#formatter = 'unique_tail'

"let g:airline#extensions#tagbar#enabled = 1
"let g:airline#extensions#tagbar#flags = 'f'
"
let g:airline#extensions#branch#enabled = 1
let g:airline#extensions#branch#empty_message = ''
let g:airline#extensions#branch#displayed_head_limit = 10
let g:airline#extensions#virtualenv#enabled = 1
let g:airline#extensions#ale#enabled = 1

"let g:airline_left_sep = '▶'
"let g:airline_left_alt_sep = '❯'
"let g:airline_right_sep = '◀'
"let g:airline_right_alt_sep = '❮'

 "设置切换Buffer快捷键"
" nnoremap <C-N> :bn<CR>
" nnoremap <C-P> :bp<CR>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"            => autoindent configuration <=                "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:indentLine_char = "│"
let g:indentLine_enabled = 1
let g:autopep8_disable_show_diff=1

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                 => rainbow delimiters <=                 "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
 "0 if you want to enable it later via :RainbowToggle
let g:rainbow_active = 1
    let g:rainbow_conf = {
    \   'guifgs': ['royalblue3', 'darkorange3', 'seagreen3', 'firebrick'],
    \   'ctermfgs': ['lightblue', 'lightyellow', 'lightcyan', 'lightmagenta'],
    \   'operators': '_,_',
    \   'parentheses': ['start=/(/ end=/)/ fold', 'start=/\[/ end=/\]/ fold', 'start=/{/ end=/}/ fold'],
    \   'separately': {
    \       '*': {},
    \       'tex': {
    \           'parentheses': ['start=/(/ end=/)/', 'start=/\[/ end=/\]/'],
    \       },
    \       'lisp': {
    \           'guifgs': ['royalblue3', 'darkorange3', 'seagreen3', 'firebrick', 'darkorchid3'],
    \       },
    \       'vim': {
    \           'parentheses': ['start=/(/ end=/)/', 'start=/\[/ end=/\]/', 'start=/{/ end=/}/ fold', 'start=/(/ end=/)/ containedin=vimFuncBody', 'start=/\[/ end=/\]/ containedin=vimFuncBody', 'start=/{/ end=/}/ fold containedin=vimFuncBody'],
    \       },
    \       'html': {
    \           'parentheses': ['start=/\v\<((area|base|br|col|embed|hr|img|input|keygen|link|menuitem|meta|param|source|track|wbr)[ >])@!\z([-_:a-zA-Z0-9]+)(\s+[-_:a-zA-Z0-9]+(\=("[^"]*"|'."'".'[^'."'".']*'."'".'|[^ '."'".'"><=`]*))?)*\>/ end=#</\z1># fold'],
    \       },
    \       'css': 0,
    \   }
    \}

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                    => Nerd Tree <=                       "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" [shift + i] to hide/show the hidden files
let g:NERDTreeWinPos = "right"
let g:NERDTreeWinSize=35
let NERDChristmasTree=1 " Make nerd tree look better

let NERDTreeCaseSensitiveSort=1 " Make file sorted by case
let NERDTreeIgnore = ['\.pyc','__pycache__','\~$','\.swp']

let NERDTreeShowHidden=1

map <leader>nn :NERDTreeToggle<cr>
map <leader>nb :NERDTreeFromBookmark<Space>
map <leader>nf :NERDTreeFind<cr>

" nerd-tree-git-plugin {{{
let g:NERDTreeIndicatorMapCustom = {
    \ "Modified"  : "✹",
    \ "Staged"    : "✚",
    \ "Untracked" : "✭",
    \ "Renamed"   : "➜",
    \ "Unmerged"  : "═",
    \ "Deleted"   : "✖",
    \ "Dirty"     : "✗",
    \ "Clean"     : "✔︎",
    \ 'Ignored'   : '☒',
    \ "Unknown"   : "?"
    \ }
""" }}}

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                    => IndentLine <=                      "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:indentLine_char = "│"
let g:indentLine_enabled = 1
let g:autopep8_disable_show_diff=1

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"           => Syntastic (syntax checker) <=               "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"使用clang对c和c++进行语法检查，对python使用pylint进行语法检查
"以下同理
let g:ale_linters = {
\   'c': ['clang'],
\   'c++': ['clang'],
\   'python': ['pylint'],
\   'go': ['go', 'golint', 'errcheck'],
\   'javascript': ['jshint'],
\}

" Disabling highlighting
let g:ale_set_highlights = 0

" Only run linting when saving the file
let g:ale_linters_explicit = 1
let g:ale_completion_delay = 500
let g:ale_echo_delay = 20
let g:ale_lint_delay = 500
let g:ale_lint_on_text_changed = 'normal'
let g:ale_lint_on_insert_leave = 1
let g:airline#extensions#ale#enabled = 1

let g:ale_c_gcc_options = '-Wall -O2 -std=c99'
let g:ale_cpp_gcc_options = '-Wall -O2 -std=c++14'
let g:ale_c_cppcheck_options = ''
let g:ale_cpp_cppcheck_options = ''

"自定义error和warning图标
let g:ale_sign_error = '✗'
let g:ale_sign_warning = '⚡'
"在vim自带的状态栏中整合ale
let g:ale_statusline_format = ['✗ %d', '⚡ %d', '✔ OK']
"显示Linter名称,出错或警告等相关信息
let g:ale_echo_msg_error_str = 'E'
let g:ale_echo_msg_warning_str = 'W'
let g:ale_echo_msg_format = '[%linter%]  %code: %%s [%severity%]'
"打开文件时不进行检查
let g:ale_lint_on_enter = 0

"普通模式下，sp前往上一个错误或警告，sn前往下一个错误或警告
nmap sp <Plug>(ale_previous_wrap)
nmap sn <Plug>(ale_next_wrap)
"<Leader>s触发/关闭语法检查
nmap <Leader>s :ALEToggle<CR>
"<Leader>d查看错误或警告的详细信息
nmap <Leader>d :ALEDetail<CR>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"             => Git gutter (Git diff) <=                  "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:gitgutter_enabled=0
nnoremap <silent> <leader>gt :GitGutterToggle<cr>

let g:gitgutter_max_signs = 500  " default value
nmap [c <Plug>GitGutterPrevHunk
nmap ]c <Plug>GitGutterNextHunk
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                    => Nerdcomment <=                     "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"" Add spaces after comment delimiters by default
"let g:NERDSpaceDelims = 1
"
"" Use compact syntax for prettified multi-line comments
"let g:NERDCompactSexyComs = 1
"
"" Align line-wise comment delimiters flush left instead of following code indentation
"let g:NERDDefaultAlign = 'left'
"
"" Set a language to use its alternate delimiters by default
"let g:NERDAltDelims_java = 1
"
"" Add your own custom formats or override the defaults
"let g:NERDCustomDelimiters = { 'c': { 'left': '/**','right': '*/' } }
"
"" Allow commenting and inverting empty lines (useful when commenting a region)
"let g:NERDCommentEmptyLines = 1
"
"" Enable trimming of trailing whitespace when uncommenting
"let g:NERDTrimTrailingWhitespace = 1

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                  => vim-gutentags <=                     "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"" gutentags 搜索工程目录的标志，碰到这些文件/目录名就停止向上一级目录递归
"let g:gutentags_project_root = ['.root', '.svn', '.git', '.hg', '.project']
"
"" 所生成的数据文件的名称
"let g:gutentags_ctags_tagfile = '.tags'
"
"" 将自动生成的 tags 文件全部放入 ~/.cache/tags 目录中，避免污染工程目录
"let s:vim_tags = expand('~/.cache/tags')
"let g:gutentags_cache_dir = s:vim_tags
"
"" 配置 ctags 的参数
"let g:gutentags_ctags_extra_args = ['--fields=+niazS', '--extra=+q']
"let g:gutentags_ctags_extra_args += ['--c++-kinds=+px']
"let g:gutentags_ctags_extra_args += ['--c-kinds=+px']
"
"" 检测 ~/.cache/tags 不存在就新建
"if !isdirectory(s:vim_tags)
"   silent! call mkdir(s:vim_tags, 'p')
"endif

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                   => YouCompleteMe <=                    "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"let g:ycm_key_list_previous_completion=['<Down>']
"let g:ycm_key_list_previous_completion=['<Up>']
"let g:ycm_seed_identifiers_with_syntax=1
"
"let g:ycm_add_preview_to_completeopt = 0
"let g:ycm_show_diagnostics_ui = 0
"let g:ycm_server_log_level = 'info'
"let g:ycm_min_num_identifier_candidate_chars = 2
"let g:ycm_min_num_of_chars_for_completion=2
"let g:ycm_collect_identifiers_from_comments_and_strings = 1
"let g:ycm_collect_identifiers_from_tags_files=1
"let g:ycm_complete_in_strings=1
"let g:ycm_complete_in_comments=1
"let g:ycm_key_invoke_completion = '<c-z>'
"set completeopt=menu,menuone
"
"noremap <c-z> <NOP>
"
"let g:ycm_semantic_triggers =  {
"           \ 'c,cpp,python,java,go,erlang,perl': ['re!\w{2}'],
"           \ 'cs,lua,javascript': ['re!\w{2}'],
"           \ }
"let g:ycm_filetype_whitelist = {
"           \ "c":1,
"           \ "cpp":1,
"           \ "objc":1,
"           \ "sh":1,
"           \ "zsh":1,
"           \ "zimbu":1,
"           \ }


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                    => Ctags Config <=                    "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" 按照名称排序
"let Tlist_Sort_Type = "name"
"
"" 在右侧显示窗口
"let Tlist_Use_Right_Window = 1
"
"" 压缩方式
"let Tlist_Compart_Format = 1
"
"" 如果只有一个buffer，kill窗口也kill掉buffer
"let Tlist_Exist_OnlyWindow = 1
"
"" 不要关闭其他文件的tags
"let Tlist_File_Fold_Auto_Close = 0
"
"" 不要显示折叠树
"let Tlist_Enable_Fold_Column = 0
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                   => UltiSnip Config <=                  "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Trigger configuration. Do not use <tab> if you use https://github.com/Valloric/YouCompleteMe.
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsListSnippets="<c-tab>"
let g:UltiSnipsJumpForwardTrigger="<c-f>"
let g:UltiSnipsJumpBackwardTrigger="<c-b>"

" If you want :UltiSnipsEdit to split your window.
let g:UltiSnipsEditSplit="vertical"

"UltiSnips will search each 'runtimepath' directory for the subdirectory names
"defined in g:UltiSnipsSnippetDirectories in the order they are defined. For
"example, if you keep your snippets in `~/.vim/mycoolsnippets` and you want to
"make use of the UltiSnips snippets that come with other plugins, add the
"following to your vimrc file.
let g:UltiSnipsSnippetDirectories=["UltiSnips", "mysnippets"]
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                      => Multi Cursor<=                   "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:multi_cursor_use_default_mapping=0

" Default mapping
let g:multi_cursor_start_word_key      = '<C-n>'
let g:multi_cursor_select_all_word_key = '<M-n>'
let g:multi_cursor_start_key           = 'g<C-n>'
let g:multi_cursor_select_all_key      = 'g<A-n>'
let g:multi_cursor_next_key            = '<C-n>'
let g:multi_cursor_prev_key            = '<C-p>'
let g:multi_cursor_skip_key            = '<C-x>'
let g:multi_cursor_quit_key            = '<Esc>'
