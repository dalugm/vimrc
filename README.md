# vimrc

My vim plugins and configuration.

## INSTALL

    git clone https://github.com/dalugm/vimrc.git ~/.vim
    cd ~/.vim
    ln -s init.vim ~/.vimrc

#### gVim on Windows

1. Add `HOME` environment variable to system environment, and set its
   value to current user's root directory.
2. After clone this repo to `HOME`, copy `init.vim` to `$HOME/.vimrc`.

### neovim

    ln -s ~/.vim ~/.config/nvim

NOTE: This configuration has some issues that are not compatible with
neovim, so I've created a new
[configuration](https://github.com/dalugm/nvimrc) for neovim.

### Documentation (NOT necessary)

Execute these commands in Vim.

    :mkdir -p ~/.vim/doc
    :!cp path/to/vim/[plugin].vim ~/.vim/doc
    :helptags ~/.vim/doc
