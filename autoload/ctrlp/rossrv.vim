" See LICENSE.txt
let s:save_cpo = &cpo
set cpo&vim

" Check required commands
let s:rossrv_exists = executable('rossrv')
let s:rospack_exists = executable('rospack')

" Load guard
if (exists('g:loaded_ctrlp_rossrv') && g:loaded_ctrlp_rossrv) ||
\   v:version < 700 || &cp ||
\   s:rossrv_exists != 1 || s:rospack_exists != 1
    finish
endif
let g:loaded_ctrlp_rossrv = 1


let s:rossrv_var = {
\   'init': 'ctrlp#rossrv#init()',
\   'accept': 'ctrlp#rossrv#accept',
\   'lname': 'rossrv',
\   'sname': 'rossrv',
\   'type': 'line',
\ }
if exists('g:ctrlp_ext_vars') && !empty(g:ctrlp_ext_vars)
    let g:ctrlp_ext_vars = add(g:ctrlp_ext_vars, s:rossrv_var)
else
    let g:ctrlp_ext_vars = [s:rossrv_var]
endif


function! ctrlp#rossrv#init()
    let srv_list = split(system('rossrv list'), '\n')
    return srv_list
endfunction

function! ctrlp#rossrv#accept(mode, str)
    call ctrlp#exit()
    let name_components = split(a:str, '[/.]')
    let package = name_components[0]
    let name = name_components[1]
    let dir = substitute(system('rospack find ' . package), '\n', '', '')
    let fullpath = dir . '/srv/' . name . '.srv'
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

function! ctrlp#rossrv#id()
    return s:id
endfunction

let &cpo = s:save_cpo
unlet s:save_cpo
