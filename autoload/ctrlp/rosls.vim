" See LICENSE.txt
let s:save_cpo = &cpo
set cpo&vim

" Check required command(s)
let s:rospack_exists = executable('rospack')

" Load guard
if (exists('g:loaded_ctrlp_rosls') && g:loaded_ctrlp_rosls) ||
\   v:version < 700 || &cp ||
\   s:rospack_exists != 1
    finish
endif
let g:loaded_ctrlp_rosls = 1


let s:rosls_var = {
\   'init': 'ctrlp#rosls#init()',
\   'accept': 'ctrlp#rosls#accept',
\   'lname': 'rosls',
\   'sname': 'rosls',
\   'type': 'line',
\ }
if exists('g:ctrlp_ext_vars') && !empty(g:ctrlp_ext_vars)
    let g:ctrlp_ext_vars = add(g:ctrlp_ext_vars, s:rosls_var)
else
    let g:ctrlp_ext_vars = [s:rosls_var]
endif


function! ctrlp#rosls#init()
    let pkg_list = split(system('rospack list-names'), '\n')
    return pkg_list
endfunction

function! ctrlp#rosls#accept(mode, str)
    call ctrlp#exit()
    let fullpath = substitute(system('rospack find ' . a:str), '\n', '', '')
    if a:mode == 'e'
        silent execute ':e ' . fullpath
    elseif a:mode == 't'
        silent execute ':tabe ' . fullpath
    elseif a:mode == 'v'
        silent execute ':vsp ' . fullpath
    elseif a:mode == 'h'
        silent execute ':sp ' . fullpath
    else
        echo "No such mode: " . mode
    endif
endfunction

let s:id = g:ctrlp_builtins + len(g:ctrlp_ext_vars)

function! ctrlp#rosls#id()
    return s:id
endfunction

let &cpo = s:save_cpo
unlet s:save_cpo
