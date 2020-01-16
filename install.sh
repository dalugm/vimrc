#!/bin/sh
###########################################################
# File Name     : install.sh
# Author        : Mou Tong
# Email         : mou.tong@qq.com
# Created Time  : 2018-01-26 08:00
# Last Modified : 2020-01-16 15:47
# By            : Mou Tong
# Description   : install my vim configuration
###########################################################
set -e

cd ~/.vim

echo 'set runtimepath+=~/.vim
source ~/.vim/vimrcs/basic.vim
source ~/.vim/vimrcs/functions.vim
source ~/.vim/vimrcs/keymappings.vim
source ~/.vim/vimrcs/plugins_config.vim

" Use private config {{{ "
    if filereadable(expand("~/.vim/my_configs.vim"))
        source ~/.vim/my_configs.vim
    endif
" }}} "

' > ~/.vimrc

echo "Installed vim configuration successfully!"
