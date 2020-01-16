" ###########################################################
" # File Name     : plugins_config.vim
" # Author        : Mou Tong
" # Email         : mou.tong@qq.com
" # Created Time  : 2018-01-26 08:00
" # Last Modified : 2020-01-16 14:48
" # By            : Mou Tong
" # Description   : plugins config for vim
" ###########################################################

" Plugins List & Config {{{ "

" Plugin List {{{ "

" Specify a directory for plugins
" - Avoid using standard Vim directory names like 'plugin'
" Make sure you use single quotes

" Use plug.vim by default
if !exists('g:rc_use_plug_manager') | let g:rc_use_plug_manager = 1 | endif
if g:rc_use_plug_manager
    if filereadable(expand("~/.vim/autoload/plug.vim"))
        call plug#begin('~/.vim/plugged')

        Plug 'vim-airline/vim-airline'
        Plug 'vim-airline/vim-airline-themes'
        if version >= 704 || version ==703 && has('patch005')
            Plug 'mbbill/undotree'
        endif
        Plug 'mattn/emmet-vim'
        Plug 'dhruvasagar/vim-table-mode'
        Plug 'machakann/vim-sandwich'
        Plug 'wellle/targets.vim'
        Plug 'kshenoy/vim-signature'
        Plug 'scrooloose/nerdcommenter'
        Plug 'Raimondi/delimitMate'
        Plug 'terryma/vim-multiple-cursors'
        Plug 'Yggdroot/indentLine'
        if version >= 704
            Plug 'SirVer/ultisnips' | Plug 'honza/vim-snippets'
        endif
        Plug 'junegunn/vim-easy-align'
        Plug 'junegunn/goyo.vim'
        Plug 'junegunn/limelight.vim'
        Plug 'ctrlpvim/ctrlp.vim'
        "Plug 'ycm-core/YouCompleteMe'
        if version >= 704
            Plug 'tpope/vim-fugitive'
        endif
        if version >= 800
            Plug 'skywind3000/asyncrun.vim'
        endif
        if executable('latexmk')
            Plug 'lervag/vimtex'
        endif
        if !has('win32')
            Plug 'metakirby5/codi.vim'
        endif
        Plug 'luochen1990/rainbow'
        Plug 'flazz/vim-colorschemes'
        " On-demand loading
        Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }

        if filereadable(expand("~/.vim/vimrc.plug"))
            source $HOME/.vim/vimrc.plug
        endif

        call plug#end()
    else
        if executable('git')
            call mkdir($HOME . "/.vim/autoload", "p")
            if has('python')
                echo "Downloading plug.vim, please wait a second..."
                exe 'py import os,urllib2; f = urllib2.urlopen("https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim"); g = os.path.join(os.path.expanduser("~"), ".vim/autoload/plug.vim"); open(g, "wb").write(f.read())'
            else
                if has('python3')
                    echo "Downloading plug.vim, please wait a second..."
                    exe 'py3 import os,urllib.request; f = urllib.request.urlopen("https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim"); g = os.path.join(os.path.expanduser("~"), ".vim/autoload/plug.vim"); open(g, "wb").write(f.read())'
                else
                    exe "silent !echo 'let g:rc_use_plug_manager = 0' > ~/.vim/vimrc.before"
                    echo "WARNING: plug.vim has been disabled due to the absence of 'python' or 'python3' features.\nIf you solve the problem and want to use it, you should delete the line with 'let g:rc_use_plug_manager = 0' in '~/.vim/vimrc.before' file.\nIf you don't take any action, that's OK. This message won't appear again. If you have any trouble contact me."
                endif
            endif
            if filereadable(expand("~/.vim/autoload/plug.vim"))
                echo "PluginManager - plug.vim just installed! vim will quit now.\nYou should relaunch vim, use PlugInstall to install plugins OR do nothing just use the basic config."
                exe 'qall!'
            endif
        else
            exe "silent !echo 'let g:rc_use_plug_manager = 0' > ~/.vim/vimrc.before"
            echo "WARNING: plug.vim has been disabled due to the absence of 'git'.\nIf you solve the problem and want to use it, you should delete the line with 'let g:rc_use_plug_manager = 0' in '~/.vim/vimrc.before' file.\nIf you don't take any action, that's OK. This message won't appear again. If you have any trouble contact me."
        endif
    endif
endif

" }}} Plugin List "

" Plugin Config {{{ "

if g:rc_use_plug_manager && filereadable(expand("~/.vim/autoload/plug.vim"))

    " Plugin Config - vim-colorschemes {{{ "

        if has("gui_running")
            set background=dark
            set transparency=10
            colorscheme solarized
        else
            set background=dark
            let g:solarized_termtrans=1
            let g:solarized_termcolors=256
            let g:solarized_contrast="normal"
            colorscheme solarized
        endif

    " }}} Plugin Config - vim-colorschemes "

   " Plugin Config - undotree {{{ "

    if filereadable(expand("~/.vim/plugged/undotree/plugin/undotree.vim"))
        let g:undotree_SplitWidth         = 40
        let g:undotree_SetFocusWhenToggle = 1
        nmap <silent> <Leader>u :UndotreeToggle<CR>
    endif

    " }}} Plugin Config - undotree "

    " Plugin Config - ultisnips {{{ "

    if filereadable(expand("~/.vim/plugged/ultisnips/plugin/UltiSnips.vim"))
        " Trigger configuration. Do not use <tab> if you use https://github.com/Valloric/YouCompleteMe.
        let g:UltiSnipsExpandTrigger="<tab>"
        let g:UltiSnipsListSnippets="<C-tab>"
        let g:UltiSnipsJumpForwardTrigger="<C-f>"
        let g:UltiSnipsJumpBackwardTrigger="<C-b>"

        " If you want :UltiSnipsEdit to split your window.
        let g:UltiSnipsEditSplit="vertical"

        "UltiSnips will search each 'runtimepath' directory for the subdirectory names
        "defined in g:UltiSnipsSnippetDirectories in the order they are defined. For
        "example, if you keep your snippets in `~/.vim/mycoolsnippets` and you want to
        "make use of the UltiSnips snippets that come with other plugins, add the
        "following to your vimrc file.
        let g:UltiSnipsSnippetDirectories=["UltiSnips", "mysnippets"]
    endif

    " }}} Plugin Config - ultisnips "

    " Plugin Config - emmet-vim {{{ "

    if filereadable(expand("~/.vim/plugged/emmet-vim/plugin/emmet.vim"))
        let g:user_emmet_install_global = 0
        autocmd FileType html,xhtml,xml,css,scss,sass,less EmmetInstall
        let g:user_emmet_leader_key = ','
    endif

    " }}} Plugin Config - emmet-vim "

    " Plugin Config - vim-table-mode {{{ "

    if filereadable(expand("~/.vim/plugged/vim-table-mode/autoload/tablemode.vim"))

        let g:table_mode_auto_align = 0
        autocmd FileType markdown,rst,org :silent TableModeEnable

        autocmd FileType markdown
                    \ let g:table_mode_corner = "|" |
                    \ let g:table_mode_corner_corner = "|" |
                    \ let g:table_mode_header_fillchar = "-" |
                    \ let g:table_mode_align_char = ":"
        autocmd FileType rst
                    \ let g:table_mode_corner = "+" |
                    \ let g:table_mode_corner_corner = "+" |
                    \ let g:table_mode_header_fillchar = "="
        autocmd FileType org
                    \ let g:table_mode_corner = "+" |
                    \ let g:table_mode_corner_corner = "|" |
                    \ let g:table_mode_header_fillchar = "-"
    endif

    " }}} Plugin Config - vim-table-mode "

    " Plugin Config - nerdcommenter {{{ "

    if filereadable(expand("~/.vim/plugged/nerdcommenter/plugin/NERD_commenter.vim"))
        " Always leave a space between the comment character and the comment
        let NERDSpaceDelims = 1
        map <Bslash> <plug>NERDCommenterInvert
        vmap <C-Bslash> <plug>NERDCommenterSexy
    endif

    " }}} Plugin Config - nerdcommenter "

    " Plugin Config - Goyo {{{ "

    if filereadable(expand("~/.vim/plugged/goyo.vim/plugin/goyo.vim"))
        nmap <silent> <C-w><Space> :Goyo<CR>
        function! s:goyo_enter()
            let b:fcstatus = &foldcolumn
            setlocal foldcolumn=0
        endfunction

        function! s:goyo_leave()
            let &foldcolumn = b:fcstatus
        endfunction

        autocmd! User GoyoEnter nested call <SID>goyo_enter()
        autocmd! User GoyoLeave nested call <SID>goyo_leave()
    endif

    " }}} Plugin Config - Goyo "

    " Plugin Config - Limelight {{{ "

    if filereadable(expand("~/.vim/plugged/limelight.vim/plugin/limelight.vim"))
        nmap <silent> <C-w><Enter> :Limelight!!<CR>
        let g:limelight_conceal_ctermfg     = 250
        let g:limelight_default_coefficient = 0.8
    endif

    " }}} Plugin Config - Limelight "

    " Plugin Config - CtrlP {{{ "

    if filereadable(expand("~/.vim/plugged/ctrlp.vim/plugin/ctrlp.vim"))
        let g:ctrlp_map          = '<Leader>o'
        let g:ctrlp_cmd          = 'CtrlPBuffer'
        let g:ctrlp_mruf_exclude = '/tmp/.*\|\.w3m/.*\|/var/folders/.*'
    endif

    " }}} Plugin Config - CtrlP "

    " Plugin Config - vim-easy-align {{{ "

    if filereadable(expand("~/.vim/plugged/vim-easy-align/plugin/easy_align.vim"))
        map <Leader>g :EasyAlign<Space>
        xmap ga <Plug>(EasyAlign)
        nmap ga <Plug>(EasyAlign)
    endif

    " }}} Plugin Config - vim-easy-align "

    " Plugin Config - airline {{{ "

    if filereadable(expand("~/.vim/plugged/vim-airline/plugin/airline.vim"))
        let g:airline#extensions#tabline#enabled   = 1
        let g:airline#extensions#tabline#fnamemod  = ':t'
        let g:airline#extensions#tabline#formatter = 'unique_tail'

        let g:airline_theme           = 'solarized'
        let g:airline_powerline_fonts = 1
        let g:airline_solarized_bg    = 'dark'


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

        " Shortkey to change buffer
        "nnoremap <C-N> :bn<CR>
        "nnoremap <C-P> :bp<CR>
    endif

    " }}} Plugin Config - airline "

    " Plugin Config - vimtex {{{ "

    if filereadable(expand("~/.vim/plugged/vimtex/autoload/vimtex.vim"))
        let g:vimtex_compiler_latexmk = {
            \ 'options' : [
            \   '-xelatex',
            \   '-shell-escape',
            \   '-verbose',
            \   '-file-line-error',
            \   '-synctex=1',
            \   '-interaction=nonstopmode',
            \ ],
            \}
        " vimtex configuration for neocomplete
        if exists('g:loaded_neocomplete')
            if !exists('g:neocomplete#sources#omni#input_patterns')
                let g:neocomplete#sources#omni#input_patterns = {}
            endif
            let g:neocomplete#sources#omni#input_patterns.tex =
                \ g:vimtex#re#neocomplete
        endif
    endif

    " }}} Plugin Config - vimtex "

    " Plugin Config - rainbow {{{ "

        let g:rainbow_active = 1 "0 if you want to enable it later via :RainbowToggle
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

    " }}} Plugin Config - rainbow "

    " Plugin Config - nerdtree {{{ "

    " `S-i` to hide/show the hidden files
    let g:NERDTreeWinPos = "right"
    let g:NERDTreeWinSize=35
    let NERDChristmasTree=1 " Make nerd tree look better

    let NERDTreeCaseSensitiveSort=1 " Make file sorted by case
    let NERDTreeIgnore = ['\.pyc','__pycache__','\~$','\.swp']

    let NERDTreeShowHidden=1

    map <Leader>tr :NERDTreeToggle<cr>
    map <Leader>tb :NERDTreeFromBookmark<Space>
    map <Leader>tf :NERDTreeFind<cr>

    " }}} Plugin Config - nerdtree "

    " Plugin Config - indentline {{{ "
    let g:indentLine_char_list       = ['|', '¦', '┆', '┊']
    let g:indentLine_enabled         = 1
    let g:autopep8_disable_show_diff = 1

    " }}} Plugin Config - indentline "

    " Plugin Config - YouCompleteMe {{{ "

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

    " }}} Plugin Config - YouCompleteMe "

    " Plugin Config - multicursor {{{ "

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

    " }}} Plugin Config - multicursor "

endif

" }}} Plugin Config "

" }}} Plugins List & Config "
