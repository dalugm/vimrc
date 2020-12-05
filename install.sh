#!/usr/bin/env bash
###########################################################
# File Name     : install.sh
# Author        : Mou Tong
# Email         : mou.tong@qq.com
# Created Time  : 2018-01-26 08:00
# Last Modified : 2020-12-05 09:57
# By            : Mou Tong
# Description   : install vim configuration
###########################################################
set -e

printf 'set runtimepath^=$HOME/.vim runtimepath+=$HOME/.vim/after
let &packpath = &runtimepath

for file in split(glob("$HOME/.vim/config/*.vim"))
    exec "source" file
endfor' > $HOME/.vim/init.vim

echo "Install vim configuration successfully."
