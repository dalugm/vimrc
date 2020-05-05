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

printf 'set runtimepath^=$HOME/.vim runtimepath+=$HOME/.vim/after
let &packpath = &runtimepath

for file in split(glob("$HOME/.vim/vimrcs/*.vim"))
    exec "source" file
endfor' > ~/.vim/init.vim

echo "Install vim configuration successfully."
