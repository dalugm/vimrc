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

" CompileRun {{{ "

function! CompileRun()
    exec "w"
    if &filetype == "c"
        exec "!gcc % -o %<"
        exec "!time ./%<"
    elseif &filetype == "cpp" | "cc"
        exec "!g++ % -o %<"
        exec "!time ./%<"
    elseif &filetype == "java"
        exec "!javac %"
        exec "!time java %<"
    elseif &filetype == "sh"
        :!time bash %
    elseif &filetype == "python"
        exec "!time python %"
    elseif &filetype == "html"
        exec "!firefox % &"
    elseif &filetype == "go"
        exec "!go build %<"
        exec "!time go run %"
    else
        echo "This file type has not been matched."
    endif
endfunc

" }}} CompileRun "

" }}} Personal Functions "
