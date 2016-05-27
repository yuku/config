" Replace netrw function with vimfiler
let g:vimfiler_as_default_explorer = 1
let b:blacklist = ['gitcommit']

augroup MyVimFilerSettings
    autocmd!
    autocmd FileType vimfiler nmap <buffer> <CR> <Plug>(vimfiler_expand_or_edit)
    autocmd FileType vimfiler setlocal nonumber
    autocmd VimEnter * if index(b:blacklist, &ft) < 0 | VimFilerExplorer -find -no-focus
augroup END
