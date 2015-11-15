" See LICENSE.txt
let s:save_cpo = &cpo
set cpo&vim

" Check required command(s)
let s:rospack_exists = executable('rospack')

" Load guard
if (exists('g:loaded_ctrlp_roscd') && g:loaded_ctrlp_roscd) ||
\   v:version < 700 || &cp ||
\   s:rospack_exists != 1
    finish
endif
let g:loaded_ctrlp_roscd = 1


let s:roscd_var = {
\   'init': 'ctrlp#roscd#init()',
\   'accept': 'ctrlp#roscd#accept',
\   'lname': 'roscd',
\   'sname': 'roscd',
\   'type': 'line',
\ }
if exists('g:ctrlp_ext_vars') && !empty(g:ctrlp_ext_vars)
    let g:ctrlp_ext_vars = add(g:ctrlp_ext_vars, s:roscd_var)
else
    let g:ctrlp_ext_vars = [s:roscd_var]
endif


function! ctrlp#roscd#init()
    let pkg_list = split(system('rospack list-names'), '\n')
    return pkg_list
endfunction

function! ctrlp#roscd#accept(mode, str)
    call ctrlp#exit()
    let fullpath = substitute(system('rospack find ' . a:str), '\n', '', '')
    execute 'cd ' . fullpath
endfunction

let s:id = g:ctrlp_builtins + len(g:ctrlp_ext_vars)

function! ctrlp#roscd#id()
    return s:id
endfunction

let &cpo = s:save_cpo
unlet s:save_cpo
