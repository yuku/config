setlocal textwidth=78
setlocal number

if v:version >= 703
    setlocal colorcolumn=79
endif

nnoremap <silent> [unite]<space> :<C-u>Unite ref/pydoc<CR>
