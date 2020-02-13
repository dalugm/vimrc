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

func! CompileRun()
    exec "w"
    if &filetype == "c"
        exec "call CompileGcc()"
        if search("mpi\.h") != 0
            exec "!mpirun -np 4 ./%<"
        else
            exec "! ./%<"
        endif
    elseif &filetype == "cpp" | "cc" | "cxx" | "cp" | "C"
        exec "call CompileGpp()"
        exec "! ./%<"
    elseif &filetype == "java"
        exec "!javac %"
        exec "!java %<"
    elseif &filetype == "sh"
        exec "!bash %"
    elseif &filetype == "python"
        exec "!python %"
    elseif &filetype == "html"
        exec "!firefox % &"
    elseif &filetype == "go"
        exec "!go build %<"
        exec "go run %"
    else
        echo "This file type has not been matched."
    endif
endfunc

func! CompileGcc()
    exec "w"
    let compilecmd="!gcc"
    let compileflag="-o %<"
    if search("mpi\.h") != 0
        let compilecmd = "!mpicc "
    endif
    if search("glut\.h") != 0
        let compileflag .= " -lglut -lGLU -lGL "
    endif
    if search("cv\.h") != 0
        let compileflag .= " -lcv -lhighgui -lcvaux "
    endif
    if search("omp\.h") != 0
        let compileflag .= " -fopenmp "
    endif
    if search("math\.h") != 0
        let compileflag .= " -lm "
    endif
    exec compilecmd." % ".compileflag
endfunc

func! CompileGpp()
    exec "w"
    let compilecmd="!g++"
    let compileflag="-o %<"
    if search("mpi\.h") != 0
        let compilecmd = "!mpic++ "
    endif
    if search("glut\.h") != 0
        let compileflag .= " -lglut -lGLU -lGL "
    endif
    if search("cv\.h") != 0
        let compileflag .= " -lcv -lhighgui -lcvaux "
    endif
    if search("omp\.h") != 0
        let compileflag .= " -fopenmp "
    endif
    if search("math\.h") != 0
        let compileflag .= " -lm "
    endif
    exec compilecmd." % ".compileflag
endfunc

" }}} CompileRun "

" }}} Personal Functions "
