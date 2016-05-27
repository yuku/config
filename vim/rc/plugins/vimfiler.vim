" Replace netrw function with vimfiler
let g:vimfiler_as_default_explorer = 1
let s:blacklist = ['gitcommit', 'gitrebase']
let s:min_width = 120

augroup MyVimFilerSettings
    autocmd!
    autocmd FileType vimfiler nmap <buffer> <CR> <Plug>(vimfiler_expand_or_edit)
    autocmd FileType vimfiler setlocal nonumber
    autocmd VimEnter * if index(s:blacklist, &ft) < 0 && winwidth(0) >= s:min_width | VimFilerExplorer -find -no-focus
augroup END
