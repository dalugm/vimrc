" ###########################################################
" # File Name     : keymappings.vim
" # Author        : Mou Tong
" # Email         : mou.tong@qq.com
" # Created Time  : 2020-01-16 15:53
" # Last Modified : 2020-02-07 21:17
" # By            : Mou Tong
" # Description   : vim key map
" ###########################################################

" Key Mappings {{{ "

" Map jk to enter normal mode
imap jk <Esc>

" Remap VIM 0 to first non-blank character
map 0 ^

" Disable highlight when <backspace> is pressed
nnoremap <silent> <BS> :nohlsearch<CR>

" Key Mappings - Leader {{{ "

" With a map leader it's possible to do extra key combinations
let mapleader = ","

" Fast saving
nnoremap <silent> <Leader>w :update<CR>

" Fast editing and reloading of vimrc configs
map <Leader>ec :e! ~/.vim/vimrcs<CR>
map <Leader>es :e! ~/.vim/my-snippets<CR>

    " Key Mappings - Buffer {{{ "

    " Close the current buffer
    map <Leader>bd :bdelete<CR>

    " Close all the buffers
    map <Leader>ba :bufdo bd<CR>

    " Change buffers
    map <Leader>l :bnext<CR>
    map <Leader>h :bprevious<CR>

    " }}} Key Mappings - Buffer "

    " Key Mappings - Tab {{{ "

    map <Leader>tn :tabnew<CR>
    map <Leader>to :tabonly<CR>
    map <Leader>tc :tabclose<CR>
    map <Leader>tm :tabmove
    map <Leader>t<Leader> :tabnext<CR>

    " Let 'tl' toggle between this and the last accessed tab
    let g:lasttab = 1
    nmap <Leader>tl :exe "tabn ".g:lasttab<CR>
    au TabLeave * let g:lasttab = tabpagenr()

    " Opens a new tab with the current buffer's path
    map <Leader>te :tabedit <c-r>=expand("%:p:h")<CR>/

    " Switch CWD to the directory of the open buffer
    map <Leader>cd :cd %:p:h<CR>:pwd<CR>

    " }}} Key Mappings - Tab "

" }}} Key Mappings - Leader "

" Key Mappings - functions {{{ "

map <F5> :call CompileRun()<CR>

" }}} Key Mappings - functions "

" }}} Key Mappings
