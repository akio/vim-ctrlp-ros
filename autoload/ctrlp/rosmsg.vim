" See LICENSE.txt
let s:save_cpo = &cpo
set cpo&vim

" Check required commands
let s:rosmsg_exists = executable('rosmsg')
let s:rospack_exists = executable('rospack')

" Load guard
if (exists('g:loaded_ctrlp_rosmsg') && g:loaded_ctrlp_rosmsg) ||
\   v:version < 700 || &cp ||
\   s:rosmsg_exists != 1 || s:rospack_exists != 1
    finish
endif
let g:loaded_ctrlp_rosmsg = 1


let s:rosmsg_var = {
\   'init': 'ctrlp#rosmsg#init()',
\   'accept': 'ctrlp#rosmsg#accept',
\   'lname': 'rosmsg',
\   'sname': 'rosmsg',
\   'type': 'line',
\ }
if exists('g:ctrlp_ext_vars') && !empty(g:ctrlp_ext_vars)
    let g:ctrlp_ext_vars = add(g:ctrlp_ext_vars, s:rosmsg_var)
else
    let g:ctrlp_ext_vars = [s:rosmsg_var]
endif


function! ctrlp#rosmsg#init()
    let msg_list = split(system('rosmsg list'), '\n')
    return msg_list
endfunction

function! ctrlp#rosmsg#accept(mode, str)
    call ctrlp#exit()
    let name_components = split(a:str, '/')
    let package = name_components[0]
    let name = name_components[1]
    let dir = substitute(system('rospack find ' . package), '\n', '', '')
    let fullpath = dir . '/msg/' . name . '.msg'
    echo fullpath
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

function! ctrlp#rosmsg#id()
    return s:id
endfunction

let &cpo = s:save_cpo
unlet s:save_cpo
