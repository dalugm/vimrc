" ###########################################################
" # File Name     : init-plugins.vim
" # Author        : Mou Tong
" # Email         : mou.tong@qq.com
" # Created Time  : 2018-01-26 08:00
" # Last Modified : 2020-05-02 23:31
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

        " better operation
        Plug 'mbbill/undotree'
        Plug 'junegunn/fzf.vim'
        Plug 'honza/vim-snippets'
        Plug 'wellle/targets.vim'
        Plug 'tpope/vim-surround'
        Plug 'mg979/vim-visual-multi'
        Plug 'junegunn/vim-easy-align'
        Plug 'liuchengxu/vim-which-key'
        Plug 'scrooloose/nerdcommenter'
        Plug 'Yggdroot/LeaderF', { 'do': './install.sh' }

        Plug 'skywind3000/asyncrun.vim'
        Plug 'skywind3000/asynctasks.vim'

        " git
        Plug 'tpope/vim-fugitive'
        Plug 'airblade/vim-gitgutter'

        " language
        Plug 'mattn/emmet-vim'
        Plug 'tpope/vim-markdown'
        Plug 'mzlogin/vim-markdown-toc'
        if executable('latexmk')
            Plug 'lervag/vimtex'
        endif

        " Appearance
        Plug 'junegunn/goyo.vim'
        Plug 'junegunn/limelight.vim'

        Plug 'Yggdroot/indentLine'
        Plug 'luochen1990/rainbow'
        Plug 'itchyny/lightline.vim'
        Plug 'ryanoasis/vim-devicons'
        Plug 'octol/vim-cpp-enhanced-highlight'
        " ColorScheme
        Plug 'dracula/vim'
        Plug 'morhetz/gruvbox'
        Plug 'ayu-theme/ayu-vim'
        Plug 'sickill/vim-monokai'
        Plug 'cocopon/iceberg.vim'
        Plug 'joshdick/onedark.vim'
        Plug 'junegunn/seoul256.vim'
        Plug 'nanotech/jellybeans.vim'
        Plug 'arcticicestudio/nord-vim'
        Plug 'NLKNguyen/papercolor-theme'
        Plug 'altercation/vim-colors-solarized'

        " On-demand loading

        " Lsp Support
        if version >= 800 || has('nvim')
            Plug 'neoclide/coc.nvim', {'branch': 'release'}
        else
            if version >= 703 && has('lua')
                Plug 'Shougo/neocomplete.vim'
            endif
        endif

        " Self maintained plugins
        Plug '/usr/local/opt/fzf'
        Plug '~/.vim/extensions/qsrc'
        Plug '~/.vim/extensions/setcolors'

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

    " Plugin Config - colorscheme {{{ "

    set background=dark
    colorscheme onedark

    " colorscheme names that use to set color
    let g:mycolors = [
                \ 'ayu'        ,
                \ 'default'    ,
                \ 'dracula'    ,
                \ 'gruvbox'    ,
                \ 'iceberg'    ,
                \ 'monokai'    ,
                \ 'jellybeans' ,
                \ 'nord'       ,
                \ 'onedark'    ,
                \ 'PaperColor' ,
                \ 'seoul256'   ,
                \ 'solarized'  ,
                \ ]

    " Use this to avoid screen color errors
    " when using `solarized` in terminal
    " Check more on plugin folder or
    " https://github.com/altercation/vim-colors-solarized
    let g:solarized_termtrans=1
    let g:onedark_termcolors=256
    let g:solarized_termcolors=256
    
    " SetColors {{{

    nnoremap <F8>   :call NextColor(1)<CR>
    nnoremap <S-F8> :call NextColor(-1)<CR>
    nnoremap <M-F8> :call NextColor(0)<CR>

    " }}} SetColors

    " }}} Plugin Config - colorscheme "

    " Plugin Config - lightline.vim {{{ "

    if filereadable(expand("~/.vim/plugged/lightline.vim/plugin/lightline.vim"))

        " -- INSERT -- is unnecessary anymore
        set noshowmode
 
        let g:lightline = {
                    \ 'colorscheme': 'one',
                    \ 'active': {
                    \   'left': [ [ 'mode', 'paste' ], 
                    \             [ 'cocstatus', 'readonly', 'filename', 'fugitive' ] ]
                    \ },
                    \ 'component_function': {
                    \   'cocstatus': 'coc#status',
                    \   'filename': 'LightlineFilename',
                    \   'fugitive': 'LightlineFugitive',
                    \ },
                    \ }

        function! LightlineModified()
            return &ft =~# 'help\|vimfiler' ? '' : &modified ? '+' : &modifiable ? '' : '-'
        endfunction
        function! LightlineReadonly()
            return &ft !~? 'help\|vimfiler' && &readonly ? 'RO' : ''
        endfunction
        function! LightlineFilename()
            return (LightlineReadonly() !=# '' ? LightlineReadonly() . ' ' : '') .
                        \ (&ft ==# 'vimfiler' ? vimfiler#get_status_string() :
                        \  &ft ==# 'unite' ? unite#get_status_string() :
                        \  &ft ==# 'vimshell' ? vimshell#get_status_string() :
                        \ expand('%:t') !=# '' ? expand('%:t') : '[No Name]') .
                        \ (LightlineModified() !=# '' ? ' ' . LightlineModified() : '')
        endfunction
        function! LightlineFugitive()
            if &ft !~? 'vimfiler' && exists('*FugitiveHead')
                return FugitiveHead()
            endif
            return ''
        endfunction

        " Use auocmd to force lightline update.
        autocmd User CocStatusChange,CocDiagnosticChange call lightline#update()

    endif

    " }}} Plugin Config - lightline.vim "

    " Plugin Config - undotree {{{ "

    if filereadable(expand("~/.vim/plugged/undotree/plugin/undotree.vim"))
        let g:undotree_SplitWidth         = 40
        let g:undotree_SetFocusWhenToggle = 1
    endif

    " }}} Plugin Config - undotree "

    " Plugin Config - emmet-vim {{{ "

    if filereadable(expand("~/.vim/plugged/emmet-vim/plugin/emmet.vim"))
        let g:user_emmet_install_global = 0
        autocmd FileType html,xhtml,xml,css,scss,sass,less EmmetInstall
        let g:user_emmet_leader_key = ','
    endif

    " }}} Plugin Config - emmet-vim "

    " Plugin Config - nerdcommenter {{{ "

    if filereadable(expand("~/.vim/plugged/nerdcommenter/plugin/NERD_commenter.vim"))

        " Always leave a space between the comment character and the comment
        let NERDSpaceDelims = 1

    endif

    " }}} Plugin Config - nerdcommenter "

    " Plugin Config - Goyo {{{ "

    if filereadable(expand("~/.vim/plugged/goyo.vim/plugin/goyo.vim"))

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

    " Plugin Config - LeaderF {{{ "

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

    " }}} Plugin Config - LeaderF "

    " Plugin Config - vim-easy-align {{{ "

    if filereadable(expand("~/.vim/plugged/vim-easy-align/plugin/easy_align.vim"))
        map <Leader>g :EasyAlign<Space>
        xmap ga <Plug>(EasyAlign)
        nmap ga <Plug>(EasyAlign)
    endif

    " }}} Plugin Config - vim-easy-align "

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

    " }}} Plugin Config - vimtex "

    " Plugin Config - vim-cpp-enhanced-highlight {{{ "

    if filereadable(expand("~/.vim/plugged/vim-cpp-enhanced-highlight/after/syntax/cpp.vim"))

        " 高亮类，成员函数，标准库和模板
        let g:cpp_class_scope_highlight = 1
        let g:cpp_member_variable_highlight = 1
        let g:cpp_concepts_highlight = 1
        let g:cpp_experimental_simple_template_highlight = 1

    endif

    " }}} Plugin Config - vim-cpp-enhanced-highlight "

    " Plugin Config - vim-markdown {{{

    if filereadable(expand("~/.vim/plugged/vim-markdown/ftplugin/markdown.vim"))
                \ && filereadable(expand("~/.vim/plugged/vim-markdown/ftplugin/markdown.vim"))

        let g:markdown_fenced_languages = ['css', 'js=javascript', 'sh']

    endif

    " }}} Plugin Config - vim-markdown
    
    " Plugin Config - rainbow {{{ "

    if filereadable(expand("~/.vim/plugged/rainbow/autoload/rainbow.vim"))
        let g:rainbow_active = 1 " 0 if you want to enable it later via :RainbowToggle
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
    endif

    " }}} Plugin Config - rainbow "

    " Plugin Config - indentline {{{ "

    if filereadable(expand("~/.vim/plugged/indentLine/after/plugin/indentLine.vim"))

        let g:indentLine_enabled = 1
        " WARNING
        " do not use non-mono char, or cursor will be in wrong position
        let g:indentLine_char_list = ['|', '¦']
        " Set indent level
        let g:indentLine_indentLevel = 5
        " Exclude file
        let g:indentLine_fileTypeExclude = ['text', 'help', 'json', 'markdown', 'coc-explorer']
        " let colorscheme highlight indentLine
        " let g:indentLine_setColors = 0

    endif

    " }}} Plugin Config - indentline "

    " Plugin Config - vim-visual-multi {{{ "

    if filereadable(expand("~/.vim/plugged/vim-visual-multi/plugin/visual-multi.vim"))

        let g:VM_mouse_mappings   = 1
        let g:VM_skip_empty_lines = 1
        let g:VM_silent_exit      = 1

        function! VM_Start()
            if exists(":DelimitMateOff") | exe 'DelimitMateOff' | endif
        endfunction

        function! VM_Exit()
            if exists(':DelimitMateOn') | exe 'DelimitMateOn' | endif
        endfunction

        let g:VM_leader = {'default': '<Leader>', 'visual': '<Leader>', 'buffer': 'z'}
        let g:VM_maps                      = {}
        let g:VM_maps["Get Operator"]      = 'gza'
        let g:VM_maps["Add Cursor At Pos"] = 'gzz'
        let g:VM_maps["Reselect Last"]     = 'gzp'
        let g:VM_maps["Visual Cursors"]    = 'gzc'
        let g:VM_maps["Undo"]              = 'u'
        let g:VM_maps["Redo"]              = '<C-r>'
        let g:VM_maps["Visual Subtract"]   = 'zs'
        let g:VM_maps["Visual Reduce"]     = 'zr'
    endif

    " }}} Plugin Config - vim-visual-multi "

    " Plugin Config - async {{{ "

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

    " }}} Plugin Config - asyncrun "

    " Plugin Config - coc.nvim {{{ "

    if filereadable(expand("~/.vim/plugged/coc.nvim/plugin/coc.vim"))
        " Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
        " delays and poor user experience.
        set updatetime=300

        " Don't pass messages to |ins-completion-menu|.
        set shortmess+=c

        " Always show the signcolumn, otherwise it would shift the text each time
        " diagnostics appear/become resolved.
        set signcolumn=yes

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

        "  trigger completion.
        inoremap <silent><expr> <M-space> coc#refresh()

        " Use <cr> to confirm completion, `<C-g>u` means break undo chain at current
        " position. Coc only does snippet and additional edit on confirm.
        if has('patch8.1.1068')
            " Use `complete_info` if your (Neo)Vim version supports it.
            inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"
        else
            imap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
        endif

        " Use `[g` and `]g` to navigate diagnostics
        nmap <silent> [g <Plug>(coc-diagnostic-prev)
        nmap <silent> ]g <Plug>(coc-diagnostic-next)

        " Use K to show documentation in preview window.
        nnoremap <silent> K :call <SID>show_documentation()<CR>

        function! s:show_documentation()
            if (index(['vim','help'], &filetype) >= 0)
                execute 'h '.expand('<cword>')
            else
                call CocAction('doHover')
            endif
        endfunction

        " Highlight the symbol and its references when holding the cursor.
        autocmd CursorHold * silent call CocActionAsync('highlight')

        " Symbol renaming.
        nmap <leader>rn <Plug>(coc-rename)

        augroup mygroup
            autocmd!
            " Setup formatexpr specified filetype(s).
            autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
            " Update signature help on jump placeholder.
            autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
        augroup end

        " Applying codeAction to the selected region.
        " Example: `<leader>aap` for current paragraph
        xmap <leader>a  <Plug>(coc-codeaction-selected)
        nmap <leader>a  <Plug>(coc-codeaction-selected)

        " Remap keys for applying codeAction to the current line.
        nmap <leader>ac  <Plug>(coc-codeaction)
        " Apply AutoFix to problem on the current line.
        nmap <leader>qf  <Plug>(coc-fix-current)

        " Introduce function text object
        " NOTE: Requires 'textDocument.documentSymbol' support from the language server.
        xmap if <Plug>(coc-funcobj-i)
        xmap af <Plug>(coc-funcobj-a)
        omap if <Plug>(coc-funcobj-i)
        omap af <Plug>(coc-funcobj-a)

        " Use <TAB> for selections ranges.
        " NOTE: Requires 'textDocument/selectionRange' support from the language server.
        " coc-tsserver, coc-python are the examples of servers that support it.
        nmap <silent> <TAB> <Plug>(coc-range-select)
        xmap <silent> <TAB> <Plug>(coc-range-select)

        " Add `:Format` command to format current buffer.
        command! -nargs=0 Format :call CocAction('format')

        " Add `:Fold` command to fold current buffer.
        command! -nargs=? Fold :call CocAction('fold', <f-args>)

        " Add `:OR` command for organize imports of the current buffer.
        command! -nargs=0 OR   :call CocAction('runCommand', 'editor.action.organizeImport')

        " Add (Neo)Vim's native statusline support.
        " NOTE: Please see `:h coc-status` for integrations with external plugins that
        " provide custom statusline: lightline.vim, vim-airline.
        set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

        " install coc extensions
        let g:coc_global_extensions = [
                    \ 'coc-clangd',
                    \ 'coc-explorer',
                    \ 'coc-highlight',
                    \ 'coc-json',
                    \ 'coc-lists',
                    \ 'coc-pairs',
                    \ 'coc-python',
                    \ 'coc-snippets',
                    \ 'coc-yank'
                    \ ]

        " coc config - explorer {{{ "

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

        " }}} coc config - explorer "
 
        " coc config - pairs {{{ "

        " disable characters for a specified filetype
        autocmd FileType vim let b:coc_pairs_disabled = ['"']

        " }}} coc config - pairs "

        " coc config - snippets {{{ "

        let g:snips_author = "dalu"
        let g:snips_email  = "mou.tong@qq.com"
        let g:snips_about  = "dalu <mou.tong@qq.com>"
        let g:snips_github = "dalu98"

        " Use <C-l> for trigger snippet expand.
        imap <C-l> <Plug>(coc-snippets-expand)

        " Use <C-j> for select text for visual placeholder of snippet.
        vmap <C-j> <Plug>(coc-snippets-select)

        " Use <C-j> for jump to next placeholder, it's default of coc.nvim
        let g:coc_snippet_next = '<c-j>'

        " Use <C-k> for jump to previous placeholder, it's default of coc.nvim
        let g:coc_snippet_prev = '<c-k>'

        " Use <C-j> for both expand and jump (make expand higher priority.)
        imap <C-j> <Plug>(coc-snippets-expand-jump)

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

        " }}} coc config - snippets "

    endif

    " }}} Plugin Config - coc.nvim "

    " Plugin Config - neocomplete {{{ "

    if filereadable(expand("~/.vim/plugged/neocomplete.vim/plugin/neocomplete.vim"))
        let g:neocomplete#enable_at_startup = 1
    else
        set omnifunc=syntaxcomplete#Complete
    endif

    " }}} Plugin Config - neocomplete "

    " Plugin Config - vim-which-key {{{ "

    if filereadable(expand("~/.vim/plugged/vim-which-key/plugin/which_key.vim"))

        " NOTE key defined here won't overwrite already defined keys

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

        " =======================================================
        " Create menus not based on existing mappings:
        " =======================================================
        " Provide commands(ex-command, <Plug>/<C-W>/<C-d> mapping, etc.) and
        " descriptions for existing mappings

        let g:which_key_map['w'] = {
                    \ 'name' : '+windows' ,
                    \ 'w' : ['<C-W>w'           , 'other-window']          ,
                    \ 'd' : ['<C-W>c'           , 'delete-window']         ,
                    \ '-' : ['<C-W>s'           , 'split-window-below']    ,
                    \ '|' : ['<C-W>v'           , 'split-window-right']    ,
                    \ '2' : ['<C-W>v'           , 'layout-double-columns'] ,
                    \ 'h' : ['<C-W>h'           , 'window-left']           ,
                    \ 'j' : ['<C-W>j'           , 'window-below']          ,
                    \ 'l' : ['<C-W>l'           , 'window-right']          ,
                    \ 'k' : ['<C-W>k'           , 'window-up']             ,
                    \ 'H' : ['<C-W>5<'          , 'expand-window-left']    ,
                    \ 'J' : ['resize +5'        , 'expand-window-below']   ,
                    \ 'L' : ['<C-W>5>'          , 'expand-window-right']   ,
                    \ 'K' : ['resize -5'        , 'expand-window-up']      ,
                    \ '=' : ['<C-W>='           , 'balance-window']        ,
                    \ 's' : ['<C-W>s'           , 'split-window-below']    ,
                    \ 'v' : ['<C-W>v'           , 'split-window-below']    ,
                    \ '?' : [':CocList windows' , 'window']                ,
                    \ 'q' : [':call asyncrun#quickfix_toggle(6)' , 'toggle-quickfix'] ,
                    \ }

        let g:which_key_map['b'] = {
                    \ 'name' : '+buffer' ,
                    \ 'd' : ['bd'               , 'delete-buffer']   ,
                    \ 'f' : ['bfirst'           , 'first-buffer']    ,
                    \ 'l' : ['blast'            , 'last-buffer']     ,
                    \ 'n' : ['bnext'            , 'next-buffer']     ,
                    \ 'p' : ['bprevious'        , 'previous-buffer'] ,
                    \ '?' : [':CocList buffers' , 'list-buffers']    ,
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

        let g:which_key_map['f'] = {
                    \ 'name' : '+file' ,
                    \ 'c' : [':e ~/.vim/config'     , 'edit-config']     ,
                    \ 'e' : [':CocCommand explorer' , 'coc-explorer']    ,
                    \ 's' : ['update'               , 'save-file']       ,
                    \ 'S' : ['Files'                , 'find-file']       ,
                    \ 'g' : [':Goyo'                , 'Goyo']            ,
                    \ 'l' : [':call LoadSession()'  , 'restore-session'] ,
                    \ 'o' : ['<Plug>(coc-openlink)' , 'open-link']       ,
                    \ 'p' : [':e ~/.vim/snippets'   , 'edit-snippets']   ,
                    \ 'r' : [':source ~/.vimrc'     , 'reload-config']   ,
                    \ 'u' : ['UndotreeToggle'       , 'undo-tree']       ,
                    \ }

        let g:which_key_map['s'] = {
                    \ 'name' : '+search' ,
                    \ 'b' : ['LeaderfBuffer'          , 'search-buffer']        ,
                    \ 'f' : ['LeaderfFile'            , 'search-file']          ,
                    \ 'h' : [':CocList searchhistory' , 'search-history']       ,
                    \ 'd' : [':Leaderf rg'            , 'search-cwd']           ,
                    \ 's' : [':CocList lines'         , 'search-buffer']        ,
                    \ 'm' : ['LeaderfMru'             , 'search-rencent-files'] ,
                    \ }

        let g:which_key_map['c'] = {
                    \ 'name' : '+code',
                    \ 'a' : ['<Plug>(coc-codeaction-selected)' , 'codeAction'] ,
                    \ 'c' : [':AsyncTask file-run'             , 'run-file']   ,
                    \ 'C' : [':AsyncTask file-build'           , 'build-file'] ,
                    \ 'f' : ['<Plug>(coc-fix-current)'         , 'fix-error']  ,
                    \ 'F' : ['<Plug>(coc-format-selected)'     , 'format']     ,
                    \ 'R' : ['<Plug>(coc-refactor)'            , 'refactor']   ,
                    \ 'g' : {
                    \ 'name' : '+goto',
                    \ 'd' : ['<Plug>(coc-definition)'      , 'definition']      ,
                    \ 'r' : ['<Plug>(coc-references)'      , 'references']      ,
                    \ 't' : ['<Plug>(coc-type-definition)' , 'type-definition'] ,
                    \ 'i' : ['<Plug>(coc-implementation)'  , 'implementation']  ,
                    \ '[' : ['<Plug>(coc-diagnostic-prev)' , 'prev error']      ,
                    \ ']' : ['<Plug>(coc-diagnostic-next)' , 'next error']      ,
                    \ },
                    \ }

        let g:which_key_map['l'] = {
                    \ 'name' : '+coc-list',
                    \ 'a' : [':CocList diagnostics'      , 'show-diagnostics']         ,
                    \ 'e' : [':CocList extensions'       , 'show-extensions']          ,
                    \ 'c' : [':CocList commands'         , 'show-commands']            ,
                    \ 'C' : [':CocConfig'                , 'edit-CocConfig']           ,
                    \ 'o' : [':CocList outline'          , 'find-current-symbol']      ,
                    \ 's' : [':CocList -I symbols'       , 'search-workspace-symbols'] ,
                    \ 'j' : [':CocNext'                  , 'action-for-next-item']     ,
                    \ 'k' : [':CocPrev'                  , 'action-for-prev-item']     ,
                    \ 'p' : [':CocListResume'            , 'resume-latest-coc-list']   ,
                    \ 'y' : [':CocList -A --normal yank' , 'open-yank-list']           ,
                    \    }

        " Remind other key
        nnoremap <silent> ] :<c-u>WhichKey ']'<CR>
        nnoremap <silent> [ :<c-u>WhichKey '['<CR>

        " Register key-value dict
        call which_key#register(',' , "g:which_key_map")
        call which_key#register(' ' , "g:which_key_map")

    endif

    " }}} Plugin Config - vim-which-key "

endif

" }}} Plugin Config "

" }}} Plugins List & Config "
