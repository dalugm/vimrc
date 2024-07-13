# vimrc

My simple vim configuration.

## INSTALL

For unix

    git clone https://github.com/dalugm/vim.git ~/.vim
    cd ~/.vim
    ln -s init.vim ~/.vimrc

For Windows

1. Add `HOME` environment variable to system environment, and set its
   value to current user's root directory.
2. After clone this repo to `HOME`, copy `init.vim` to `$HOME/_vimrc`
   or `$VIM/_vimrc`.

### neovim (not recommend to use this config with neovim)

    ln -s ~/.vim ~/.config/nvim

NOTE: This repo is for vim only, for neovim check this
[repo](https://github.com/dalugm/nvim).
