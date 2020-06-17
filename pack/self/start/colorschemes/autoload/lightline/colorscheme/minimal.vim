" =============================================================================
" Filename: autoload/lightline/colorscheme/minimal.vim
" Author: dalu <mou.tong@qq.com>
" License: MIT
" Created: 2020/04/24 20:27:51
" Last Modified: 2020-06-06 16:49
" =============================================================================

" [ [ fg, bg ] ] colors
let s:white  = [ "#f8f4ed" , 51  ]
let s:blue   = [ "#1772b4" , 75  ]
let s:green  = [ "#1ba784" , 76  ]
let s:purple = [ "#7e1671" , 176 ]
let s:red1   = [ "#e06c75" , 168 ]
let s:red2   = [ "#f9723d" , 168 ]
let s:yellow = [ "#e2d849" , 180 ]
let s:none   = [ "NONE" , "NONE" ]

let s:p = {'normal': {}, 'inactive': {}, 'insert': {}, 'replace': {}, 'visual': {}, 'tabline': {}}

let s:fgn = [ "#126e82" , 0 ]
let s:bn  = [ "#f8f4ed" , 51 ]
let s:bi  = [ "#20894d" , 82 ]
let s:br  = [ "#de1c31" , 168 ]
let s:bv  = [ "#ffd111" , 9 ]


" Common
let s:p.normal.middle  = [ [ s:white, s:none ] ]
let s:p.normal.right   = [ [ s:white, s:none ], [ s:white, s:none ] ]
let s:p.normal.warning = [ [ s:white, s:bv ] ]
let s:p.normal.error   = [ [ s:white, s:bv ] ]

let s:p.inactive.left   = [ [ s:fgn, s:none ], [ s:fgn, s:none ] ]
let s:p.inactive.middle = [ [ s:purple, s:none ] ]
let s:p.inactive.right  = [ [ s:purple, s:none ], [ s:purple, s:none ] ]

let s:p.normal.left  = [ [ s:bn, s:none, 'bold' ], [ s:white, s:none ] ]
let s:p.insert.left  = [ [ s:bi, s:none, 'bold' ], [ s:white, s:none ] ]
let s:p.replace.left = [ [ s:br, s:none, 'bold' ], [ s:white, s:none ] ]
let s:p.visual.left  = [ [ s:bv, s:none, 'bold' ], [ s:white, s:none ] ]

let s:p.tabline.left   = [ [ s:purple, s:none ] ]
let s:p.tabline.middle = [ [ s:purple, s:none ] ]
let s:p.tabline.right  = [ [ s:purple, s:none ] ]
let s:p.tabline.tabsel = [ [ s:none, s:purple ] ]

let g:lightline#colorscheme#minimal#palette = lightline#colorscheme#flatten(s:p)
