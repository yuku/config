" Replace netrw function with vimfiler
let g:vimfiler_as_default_explorer = 1
let s:blacklist = ['gitcommit', 'gitrebase']
let s:min_width = 120

nnoremap <silent> [unite]e :<C-u>VimFilerExplorer -no-focus -toggle -buffer-name=filer -winwidth=40<CR>

augroup MyVimFilerSettings
    autocmd!
    autocmd FileType vimfiler nmap <buffer> <CR> <Plug>(vimfiler_expand_or_edit)
    autocmd FileType vimfiler setlocal nonumber
    autocmd VimEnter * if index(s:blacklist, &ft) < 0 && winwidth(0) >= s:min_width | execute "normal [unite]e" | endif
    autocmd BufEnter * if (winnr('$') == 1 && &filetype ==# 'vimfiler') | q | endif
augroup END
