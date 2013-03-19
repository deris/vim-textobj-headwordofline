" textobj-headwordofline - Text objects for head word of line
" Version: 0.0.1
" Copyright (C) 2013 deris0126
" License: So-called MIT license  {{{
"     Permission is hereby granted, free of charge, to any person obtaining
"     a copy of this software and associated documentation files (the
"     "Software"), to deal in the Software without restriction, including
"     without limitation the rights to use, copy, modify, merge, publish,
"     distribute, sublicense, and/or sell copies of the Software, and to
"     permit persons to whom the Software is furnished to do so, subject to
"     the following conditions:
"
"     The above copyright notice and this permission notice shall be included
"     in all copies or substantial portions of the Software.
"
"     THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS
"     OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
"     MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
"     IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY
"     CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
"     TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
"     SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
" }}}

if exists('g:loaded_textobj_headwordofline')  "{{{1
  finish
endif


let s:save_cpo = &cpo
set cpo&vim







" Interface  "{{{1

call textobj#user#plugin('headwordofline', {
\      '-': {
\        '*sfile*': expand('<sfile>:p'),
\        'select-a': 'ah',  '*select-a-function*': 's:select_a',
\        'select-i': 'ih',  '*select-i-function*': 's:select_i'
\      }
\    })








" Misc.  "{{{1
function! s:select_a()
  return s:select(0)
endfunction

function! s:select_i()
  return s:select(1)
endfunction

function! s:select(in)
  let first_pos = getpos('.')

  let tail_pos = first_pos
  let tail_pos[2] = col('$') <= 1 ? 1 : col('$') - 1

  normal! ^
  let start_pos = getpos('.')

  let save_whichwrap = &whichwrap
  set whichwrap=

  try
    normal! w
    let end_pos = getpos('.')

    if first_pos[1] != end_pos[1]
      let end_pos = tail_pos
    else
      if a:in == 1
        normal! ge
      else
        normal! h
      endif
      let end_pos = getpos('.')
    endif
  finally
    let &whichwrap = save_whichwrap
  endtry

  return ['v', start_pos, end_pos]
endfunction








" Fin.  "{{{1

let g:loaded_textobj_headwordofline = 1
let &cpo = s:save_cpo
unlet s:save_cpo







" __END__
" vim: foldmethod=marker
