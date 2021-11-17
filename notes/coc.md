# split coc config

take `coc-explorer` as an example:

put this coc-settings.json into differnt vim config files.

```vimscript
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

# lsp

## C/C++/Obj-C

using clangd, just install [coc-clangd](https://github.com/clangd/coc-clangd) or:

``` js
"languageserver": {
  "clangd": {
    "command": "clangd",
    "rootPatterns": ["compile_flags.txt", "compile_commands.json"],
    "filetypes": ["c", "cc", "cpp", "c++", "objc", "objcpp"]
  }
}
```

When using [ccls](https://github.com/MaskRay/ccls):

``` js
"ccls": {
  "command": "ccls",
  "filetypes": ["c", "cc", "cpp", "c++", "objc", "objcpp"],
  "rootPatterns": [".ccls", "compile_commands.json", ".git/", ".hg/"],
  "initializationOptions": {
    "cache": {
      "directory": "/tmp/ccls"
    }
  }
}
```
