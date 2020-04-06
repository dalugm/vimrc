#!/usr/bin/env bash
###########################################################
# File Name     : install.sh
# Author        : Mou Tong
# Email         : mou.tong@qq.com
# Created Time  : 2018-01-26 08:00
# Last Modified : 2020-04-06 14:42
# By            : Mou Tong
# Description   : install my vim configuration
###########################################################
set -e

cd ~/.vim

printf 'set runtimepath+=~/.vim

for file in split(glob("vimrcs/*.vim"))
    exec "source" file
endfor

" Use private config {{{ "
    if filereadable(expand("~/.vim/my_configs.vim"))
        source ~/.vim/my_configs.vim
    endif
" }}} "

  ' > ~/.vim/vimrc

echo "Install vim configuration successfully."
