" ###########################################################
" # File Name     : functions.vim
" # Author        : Mou Tong
" # Email         : mou.tong@qq.com
" # Created Time  : 2018-01-26 08:00
" # Last Modified : 2020-05-02 23:14
" # By            : Mou Tong
" # Description   : personal function
" ###########################################################

" Personal Functions {{{ "

" Coc function {{{ "

" }}} CocFunction "

" ToggleTransparent {{{ "

function ToggleTransparent()
    highlight Normal guibg=NONE ctermbg=None
endfunction

" }}} ToggleTransparent "

" CompileRun {{{ "

function! CompileRun()
    execute "w"
    if (&filetype == 'c')
        execute "AsyncRun gcc % -o %<; time ./%<"
    endif
    if (&filetype == 'cpp')
        execute "AsyncRun g++ % -o %<; time ./%<"
    endif
    if (&filetype == 'python')
        execute "AsyncRun time python3 %"
    endif
    if (&filetype == 'php')
        execute "AsyncRun time php %"
    endif
    if (&filetype == 'javascript')
        execute "AsyncRun time node %"
    endif
    if (&filetype == 'java')
        execute "AsyncRun time javac Main.java; java Main;"
    endif
    if (&filetype == 'coffee')
        execute "AsyncRun time coffee %"
    endif
    if (&filetype == 'rust')
        execute "AsyncRun time rustc %; ./%< ;"
    endif
    if (&filetype == 'haskell' || &filetype == 'lhaskell')
        execute "AsyncRun time ghc %; ./%< ;"
    endif
    if (&filetype == 'tex')
        execute "AsyncRun time pdflatex %;"
    endif
    if (&filetype == 'markdown')
        execute "AsyncRun time pandoc -s -S -o %<.pdf %;"
    endif
endfunction

" }}} CompileRun "

" }}} Personal Functions "
