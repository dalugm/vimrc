set runtimepath^=$HOME/.vim runtimepath+=$HOME/.vim/after
let &packpath = &runtimepath

for file in split(glob("$HOME/.vim/vimrcs/*.vim"))
	exec "source" file
endfor
