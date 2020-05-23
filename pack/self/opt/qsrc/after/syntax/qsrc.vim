" Filename: qsrc.vim
" Author: dalu <mou.tong@qq.com>
" Maintainer: dalu <mou.tong@qq.com>
" Created: 2020-04-04 20:07
" Last Upated:
"          By:
" Keywords: qsrc, highlight
"
" Version: 0.1
"
" Changelog:
"   0.1 - initial version.
"
" Commentary:
"
" syntax highlight for qsrc files
"
"
" Code:

" -----------------------------------------------------------------------------
"  Highlight function names.
" -----------------------------------------------------------------------------
if !exists('g:qsrc_no_function_highlight')
    syn match    cCustomParen    transparent "(" contains=cParen contains=cCppParen
    syn match    cCustomFunc     "\w\+\s*(\@=" contains=cCustomParen
    hi def link cCustomFunc  Function
endif

" -----------------------------------------------------------------------------
"  Highlight member variable names.
" -----------------------------------------------------------------------------
if exists('g:qsrc_member_variable_highlight') && g:qsrc_member_variable_highlight
    syn match   cCustomDot    "\." contained
    syn match   cCustomPtr    "->" contained
    syn match   cCustomMemVar "\(\.\|->\)\h\w*" contains=cCustomDot,cCustomPtr
    hi def link cCustomMemVar Function
endif
