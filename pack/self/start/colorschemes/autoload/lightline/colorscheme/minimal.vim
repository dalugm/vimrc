" =============================================================================
" Filename: autoload/lightline/colorscheme/minimal.vim
" Author: dalu <mou.tong@qq.com>
" License: MIT
" Created: 2020/04/24 20:27:51
" Last Modified: 2020-06-06 16:49
" =============================================================================

" Common colors
let s:blue   = [ '#1772b4', 75 ]
let s:green  = [ '#1ba784', 76 ]
let s:purple = [ '#c678dd', 176 ]
let s:red1   = [ '#e06c75', 168 ]
let s:red2   = [ '#f9723d', 168 ]
let s:yellow = [ '#e2d849', 180 ]

" [ [ fg, bg ] ] colors
let s:p = {'normal': {}, 'inactive': {}, 'insert': {}, 'replace': {}, 'visual': {}, 'tabline': {}}

let s:bg  = ["NONE" , "NONE"]
let s:fg  = ["#f8f4ed" , 7]
let s:fgn = ["#2b1216" , 0]
let s:bn  = ["#f8f4ed" , 51]
let s:bi  = ["#96c24e" , 82]
let s:br  = ["#ec2b24" , 11]
let s:bv  = ["#ffd111" , 9]


" Common
let s:p.normal.middle = [ [ s:fg, s:bg ] ]
let s:p.normal.right = [ [ s:fg, s:bg ], [ s:fg, s:bg ] ]
let s:p.normal.warning = [ [ s:fg, s:bv ] ]
let s:p.normal.error = [ [ s:fg, s:bv ] ]

let s:p.inactive.left =  [ [ s:fgn, s:bg ], [ s:fgn, s:bg ] ]
let s:p.inactive.middle = [ [ s:fg, s:bg ] ]
let s:p.inactive.right = [ [ s:fg, s:bg ], [ s:fg, s:bg ] ]

let s:p.normal.left = [ [ s:bn, s:bg, 'bold' ], [ s:fg, s:bg ] ]
let s:p.insert.left = [ [ s:bi, s:bg, 'bold' ], [ s:fg, s:bg ] ]
let s:p.replace.left = [ [ s:br, s:bg, 'bold' ], [ s:fg, s:bg ] ]
let s:p.visual.left = [ [ s:bv, s:bg, 'bold' ], [ s:fg, s:bg ] ]

let s:p.tabline.left = [ [ s:fg, s:bg ] ]
let s:p.tabline.middle = [ [ s:fg, s:bg ] ]
let s:p.tabline.right = [ [ s:fg, s:bg ] ]
let s:p.tabline.tabsel = [ [ s:bg, s:fg ] ]

let g:lightline#colorscheme#minimal#palette = lightline#colorscheme#flatten(s:p)
