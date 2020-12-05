# split coc config

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
