# vimrc

My vim plugins and configuration

* This configuration is light weight because I only use vim in terminal.

## INSTALL

    git clone --depth 1 https://github.com/dalugm/vimrc.git $HOME/.vim && cd .vim
    bash install.sh [basic|extend]

* Do NOT support Windows, please install it **manually**.

#### gVim on Windows

1. Install gVim to anywhere you like. Here I'll assume you install gvim82 to `D:\Apps\Vim`.
2. Add `D:\Apps\Vim\vim82` to PATH.
3. Download ZIP file and copy vimrc to HOME directory.
4. Copy (or move, whatever, since copy won't pollute git repo) current repo's `init.vim` to `~\_vimrc`.
5. Change the content in `_vimrc`.

   ```vimscript
   set runtimepath^=~\vimrc runtimepath+=~\vimrc\after
   let &packpath = &runtimepath

   source ~\vimrc\config\init-basic.vim
   source ~\vimrc\config\init-extend.vim
   ```

5. (NOT necessary) Install latest [ctags](http://ctags.sourceforge.net/), and copy `ctags.exe` to `D:\Apps\Vim\vim82`.
6. Enjoy!

### neovim

    ln -s ~/.vim ~/.config/nvim

### Documentation (NOT necessary)

Execute these commands in Vim.

    :mkdir -p ~/.vim/doc
    :!cp path/to/vim/[plugin].vim ~/.vim/doc
    :helptags ~/.vim/doc
