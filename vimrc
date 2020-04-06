set runtimepath+=~/.vim

for file in split(glob("vimrcs/*.vim"))
    exec "source" file
endfor

" Use private config {{{ "
    if filereadable(expand("~/.vim/my_configs.vim"))
        source ~/.vim/my_configs.vim
    endif
" }}} "

  