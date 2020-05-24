# vimrc

My vim plugins and configuration

Inspired by [ashfinal](https://github.com/ashfinal/vimrc-config)

* This configuration is light weight because I only use vim in terminal.

## INSTALL

### Unix

    git clone --depth 1 https://github.com/dalu98/vimrc.git $HOME/.vim && cd .vim
    chmod +x install.sh && ./install.sh
    ln -s -f $HOME/.vim/init.vim $HOME/.vimrc

### Windows

    git clone --depth 1 https://github.com/dalu98/vimrc.git $HOME\vimfiles && cd .vim
    chmod +x install.sh && install.sh
    ln -s -f $HOME\vimfiles\init.vim $HOME\_vimrc

### neovim

    ln -s ~/.vim ~/.config/nvim

#### split coc config

take `coc-explorer` as an example:

put this coc-settings.json into differnt vim config files.

```vim script
" common.vim
let g:coc_common = {
    \   "coc.preferences.currentFunctionSymbolAutoUpdate": v:true,
    \   "coc.source.ultisnips.priority": 10,
    \   "coc.source.buffer.priority": 5,
    \   "coc.source.word.priority": 1,
    \ }

" explorer.vim
let g:coc_explorer = {
    \   "explorer.icon.enableNerdfont": v:true,
    \   "explorer.keyMappings": {
    \     "<space>": "normal:j"
    \   },
    \ }

let g:coc_user_config = extend(g:coc_common, g:coc_explorer)
```

### Add Bash lsp for `coc.nvim`

    npm i -g bash-language-server

### Documentation

    :mkdir -p ~/.vim/doc
    :!cp path/to/[plugin].vim ~/.vim/doc
    :helptags ~/.vim/doc
