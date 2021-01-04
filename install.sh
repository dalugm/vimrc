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
    printf 'set runtimepath^=~/.vim runtimepath+=~/.vim/after
let &packpath = &runtimepath

source ~/.vim/config/init-basic.vim
source ~/.vim/config/init-extend.vim
' > ~/.vim/init.vim
elif [ "$1" = "basic" ]; then
    printf 'set runtimepath^=~/.vim runtimepath+=~/.vim/after
let &packpath = &runtimepath

source ~/.vim/config/init-basic.vim
' > ~/.vim/init.vim
else
    printf 'set runtimepath^=~/.vim runtimepath+=~/.vim/after
let &packpath = &runtimepath

source ~/.vim/config/init-basic.vim
source ~/.vim/config/init-extend.vim
' > ~/.vim/init.vim
fi

if [ "$OSTYPE" = msys* ]; then
    ln -s -f ~/.vim/init.vim ~/_vimrc
else
    ln -s -f ~/.vim/init.vim ~/.vimrc
fi

echo "Install vim configuration successfully."
