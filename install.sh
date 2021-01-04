#!/usr/bin/env bash
###########################################################
# File Name     : install.sh
# Author        : Mou Tong
# Email         : mou.tong@qq.com
# Created Time  : 2018-01-26 08:00
# Last Modified : 2021-01-04 14:00
# By            : Mou Tong
# Description   : install vim configuration
###########################################################
set -e

if [ "$1" = "extend" ]; then
    printf 'set runtimepath^=$HOME/.vim runtimepath+=$HOME/.vim/after
let &packpath = &runtimepath

source $HOME/.vim/config/init-basic.vim
source $HOME/.vim/config/init-extend.vim

" Private config {{{ "
if filereadable(expand("$HOME/.vim/vimrc_private.vim"))
    source $HOME/.vim/vimrc_private.vim
endif
" }}} "
' > $HOME/.vim/init.vim

    echo "Install vim configuration successfully."
elif [ "$1" = "basic" ]; then
    printf 'set runtimepath^=$HOME/.vim runtimepath+=$HOME/.vim/after
let &packpath = &runtimepath

source $HOME/.vim/config/init-basic.vim

" Private config {{{ "
if filereadable(expand("$HOME/.vim/vimrc_private.vim"))
    source $HOME/.vim/vimrc_private.vim
endif
" }}} "
' > $HOME/.vim/init.vim

    echo "Install basic vim configuration successfully."
else
    printf 'set runtimepath^=$HOME/.vim runtimepath+=$HOME/.vim/after
let &packpath = &runtimepath

source $HOME/.vim/config/init-basic.vim
source $HOME/.vim/config/init-extend.vim

" Private config {{{ "
if filereadable(expand("$HOME/.vim/vimrc_private.vim"))
    source $HOME/.vim/vimrc_private.vim
endif
" }}} "
' > $HOME/.vim/init.vim

    echo "Install vim configuration successfully."
fi

if [ "$OSTYPE" = windows* ]; then
    ln -s -f $HOME/.vim/init.vim $HOME/_vimrc
else
    ln -s -f $HOME/.vim/init.vim $HOME/.vimrc
fi
