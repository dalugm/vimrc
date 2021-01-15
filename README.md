# vimrc

My vim plugins and configuration

* This configuration is light weight because I only use vim in terminal.

## INSTALL

    git clone --depth 1 https://github.com/dalugm/vimrc.git $HOME/.vim && cd .vim
    bash install.sh [basic|extend]

* Do NOT support Windows, please install it **manually** when encountering problems.

### neovim

    ln -s ~/.vim ~/.config/nvim

### Documentation (NOT necessary)

Execute these commands in Vim.

    :mkdir -p ~/.vim/doc
    :!cp path/to/vim/[plugin].vim ~/.vim/doc
    :helptags ~/.vim/doc
