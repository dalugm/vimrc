#!/bin/sh
set -e

cd ~/.vim

echo 'set runtimepath+=~/.vim
source ~/.vim/vimrcs/basic.vim
source ~/.vim/vimrcs/filetypes.vim
source ~/.vim/vimrcs/plugins_config.vim
source ~/.vim/vimrcs/extended.vim

" Use private config {
    if filereadable(expand("~/.vim/my_configs.vim"))
        source ~/.vim/my_configs.vim
    endif
" }

' > ~/.vimrc

echo "Installed the Ultimate Vim configuration successfully! Enjoy :-)"
