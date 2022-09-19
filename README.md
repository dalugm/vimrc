# vimrc

My vim plugins and configuration.

## INSTALL

    $ git clone --depth 1 https://github.com/dalugm/vimrc.git ~/.vim
    $ cd ~/.vim
    $ ln -s init.vim ~/.vimrc

#### gVim on Windows

1. Install gVim to anywhere you like. Here I'll assume you install gvim82 to
   `D:\Apps\Vim`.
2. Add `D:\Apps\Vim\vim82` to PATH.
3. Download ZIP file and copy vimrc to HOME directory.
4. Enjoy!

### neovim

    ln -s ~/.vim ~/.config/nvim

NOTE: I've made a new [configuration](https://github.com/dalugm/nvimrc) for neovim.

### Documentation (NOT necessary)

Execute these commands in Vim.

    :mkdir -p ~/.vim/doc
    :!cp path/to/vim/[plugin].vim ~/.vim/doc
    :helptags ~/.vim/doc
