" ###########################################################
" # File Name     : init-funcs.vim
" # Author        : Mou Tong
" # Email         : mou.tong@qq.com
" # Created Time  : 2018-01-26 08:00
" # Last Modified : 2020-05-02 23:14
" # By            : Mou Tong
" # Description   : personal function
" ###########################################################

" Personal Functions {{{ "

" Coc function {{{ "

function FloatingTransparen()
    highlight CocFloating ctermbg=None
endfunction

" }}} CocFunction "

" ToggleTransparent {{{ "

function ToggleTransparent()
    highlight Normal guibg=NONE ctermbg=None
endfunction

" }}} ToggleTransparent "

" }}} Personal Functions "
