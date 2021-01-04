set runtimepath^=$HOME/.vim runtimepath+=$HOME/.vim/after
let &packpath = &runtimepath

source $HOME/.vim/config/init-basic.vim
source $HOME/.vim/config/init-extend.vim

" Private config {{{ "
if filereadable(expand("$HOME/.vim/vimrc_private.vim"))
    source $HOME/.vim/vimrc_private.vim
endif
" }}} "
