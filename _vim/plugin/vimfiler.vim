NeoBundle 'Shougo/vimfiler', {'depends': 'Shougo/unite.vim'}
" Use vimfiler as file manager instead of netrw.
let g:vimfiler_as_default_explorer = 1
" Edit file by tabedit.
"let g:vimfiler_edit_action = 'tabopen'
" Enable file operation commands.
let g:vimfiler_safe_mode_by_default = 0
" Use with powerline
let g:vimfiler_force_overwrite_statusline = 0

nnoremap <silent><space>e :<C-u>VimFilerCurrentDir -explorer -find -split 
      \ -simple -winwidth=30 -toggle -no-quit<CR>

augroup VimFilerSettings
    autocmd!
    autocmd FileType vimfiler nnoremap <buffer> <C-j>
          \ :<C-u>call EasyMotion#JK(0, 0)<CR>
    autocmd FileType vimfiler nmap <buffer> <2-LeftMouse>
          \ <Plug>(vimfiler_edit_file)
    " Starts VimFiler automatically if no files were specified.
    "if !argc()
    "    autocmd VimEnter * VimFiler -status
    "endif
augroup END
