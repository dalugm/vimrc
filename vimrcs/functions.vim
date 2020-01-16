" ###########################################################
" # File Name     : functions.vim
" # Author        : Mou Tong
" # Email         : mou.tong@qq.com
" # Created Time  : 2020-01-16 15:53
" # Last Modified : 2020-01-16 15:58
" # By            : Mou Tong
" # Description   : personal function
" ###########################################################

" Personal Functions {{{ "

" DeleteTillSlash {{{ "

func! DeleteTillSlash()
    let g:cmd = getcmdline()

    if has("win16") || has("win32")
        let g:cmd_edited = substitute(g:cmd, "\\(.*\[\\\\]\\).*", "\\1", "")
    else
        let g:cmd_edited = substitute(g:cmd, "\\(.*\[/\]\\).*", "\\1", "")
    endif

    if g:cmd == g:cmd_edited
        if has("win16") || has("win32")
            let g:cmd_edited = substitute(g:cmd, "\\(.*\[\\\\\]\\).*\[\\\\\]", "\\1", "")
        else
            let g:cmd_edited = substitute(g:cmd, "\\(.*\[/\]\\).*/", "\\1", "")
        endif
    endif

    return g:cmd_edited
endfunc

" }}} DeleteTillSlash "

" CurrentFileDir {{{ "

func! CurrentFileDir(cmd)
    return a:cmd . " " . expand("%:p:h") . "/"
endfunc

" }}} CurrentFileDir "

" Title {{{ "

" Auto insert when create a new file
"autocmd BufNewFile *.sh,*.py,*.c,*.cpp, exec ":call Title()"
"autocmd BufWritePre *.sh,*.py,*.c,*.cpp, exec ":call Title()"

function AddTitle()
    if &filetype == 'c'
        call append(0,"/***********************************************************")
        call append(1,"# File Name     : ".expand("%:t"))
        call append(2,"# Author        : ".$author_name)
        call append(3,"# Email         : ".$author_email)
        call append(4,"# Created Time  : ".strftime("%Y-%m-%d %H:%M"))
        call append(5,"# Last Modified : ".strftime("%Y-%m-%d %H:%M"))
        call append(6,"# By            : ")
        call append(7,"# Description   : ")
        call append(8,"***********************************************************/")
    elseif &filetype == 'cpp'
        call append(0,"/***********************************************************")
        call append(1,"# File Name     : ".expand("%:t"))
        call append(2,"# Author        : ".$author_name)
        call append(3,"# Email         : ".$author_email)
        call append(4,"# Created Time  : ".strftime("%Y-%m-%d %H:%M"))
        call append(5,"# Last Modified : ".strftime("%Y-%m-%d %H:%M"))
        call append(6,"# By            : ")
        call append(7,"# Description   : ")
        call append(8,"***********************************************************/")
    elseif &filetype == 'python'
        call append(0,"#!/usr/bin/env python")
        call append(1,"# -*- coding:utf-8 -*-")
        call append(2,"############################################################")
        call append(3,"# File Name     : ".expand("%:t"))
        call append(4,"# Author        : ".$author_name)
        call append(5,"# Email         : ".$author_email)
        call append(6,"# Created Time  : ".strftime("%Y-%m-%d %H:%M"))
        call append(7,"# Last Modified : ".strftime("%Y-%m-%d %H:%M"))
        call append(8,"# By            : ")
        call append(9,"# Description   : ")
        call append(10,"############################################################")
    else
        call append(0,"############################################################")
        call append(1,"# File Name     : ".expand("%:t"))
        call append(2,"# Author        : ".$author_name)
        call append(3,"# Email         : ".$author_email)
        call append(4,"# Created Time  : ".strftime("%Y-%m-%d %H:%M"))
        call append(5,"# Last Modified : ".strftime("%Y-%m-%d %H:%M"))
        call append(6,"# By            : ")
        call append(7,"# Description   : ")
        call append(8,"############################################################")
    endif
    echohl WarningMsg | echo "Add the copyright." | echohl None
endfunction

function UpdateTitle()
    normal m'
    execute '/# Last Modified/s@:.*$@\=strftime(": %Y-%m-%d %H:%M")@'
    normal ''
    normal mk
    execute '/# File Name/s@:.*$@\=": ".expand("%:t")@'
    execute "noh"
    normal 'k
    echohl WarningMsg | echo "Update the copyright." | echohl None
endfunction

function Title()
    let n = 1
    while n < 11
        let line = getline(n)
        if line =~ '^\#\s*\S*Last\sModified\s*\S*.*$'
            call UpdateTitle()
            return
        endif
        let n = n + 1
    endwhile
    call AddTitle()
endfunction

" }}} Title "

" CompileRun {{{ "

function! CompileRun()
    exec "w"
    if &filetype == 'c'
        exec "!gcc % -o %<"
        exec "!time ./%<"
    elseif &filetype == 'cpp'
        exec "!g++ % -o %<"
        exec "!time ./%<"
    elseif &filetype == 'java'
        exec "!javac %"
        exec "!time java %<"
    elseif &filetype == 'sh'
        :!time bash %
    elseif &filetype == 'python'
        exec "!time python %"
    elseif &filetype == 'html'
        exec "!firefox % &"
    elseif &filetype == 'go'
        exec "!go build %<"
        exec "!time go run %"
    elseif &filetype == 'mkd'
        exec "!~/.vim/markdown.pl % > %.html &"
        exec "!firefox %.html &"
    endif
endfunc

" }}} CompileRun "

" }}} Personal Functions "
