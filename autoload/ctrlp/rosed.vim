" See LICENSE.txt
let s:save_cpo = &cpo
set cpo&vim

" Check required command(s)
let s:rospack_exists = executable('rospack')

" Load guard
if (exists('g:loaded_ctrlp_rosed') && g:loaded_ctrlp_rosed) ||
\   v:version < 700 || &cp ||
\   s:rospack_exists != 1
    finish
endif
let g:loaded_ctrlp_rosed = 1


let s:rosed_var = {
\   'init': 'ctrlp#rosed#init()',
\   'accept': 'ctrlp#rosed#accept',
\   'lname': 'rosed',
\   'sname': 'rosed',
\   'type': 'line',
\ }
if exists('g:ctrlp_ext_vars') && !empty(g:ctrlp_ext_vars)
    let g:ctrlp_ext_vars = add(g:ctrlp_ext_vars, s:rosed_var)
else
    let g:ctrlp_ext_vars = [s:rosed_var]
endif


function! ctrlp#rosed#init()
    let pkg_list = split(system('rospack list-names'), '\n')
    return pkg_list
endfunction

function! ctrlp#rosed#accept(mode, str)
    call ctrlp#exit()
    let fullpath = substitute(system('rospack find ' . a:str), '\n', '', '')
    call ctrlp#init(0, {'dir': fullpath})
endfunction

let s:id = g:ctrlp_builtins + len(g:ctrlp_ext_vars)

function! ctrlp#rosed#id()
    return s:id
endfunction

let &cpo = s:save_cpo
unlet s:save_cpo
