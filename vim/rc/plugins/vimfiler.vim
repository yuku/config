" Replace netrw function with vimfiler
let g:vimfiler_as_default_explorer = 1
let s:blacklist = ['gitcommit', 'gitrebase']
let s:min_width = 120

function! s:vimfiler_my_settings()
  nmap <silent><buffer><C-i>       <Plug>(vimfiler_split_edit_file)
  nmap <silent><buffer><CR>        <Plug>(vimfiler_expand_or_edit)
  nmap <silent><buffer><expr><C-k> vimfiler#do_switch_action('split')
  setlocal nonumber
endfunction

nnoremap <silent> [unite]e :<C-u>VimFilerExplorer -no-focus -toggle -buffer-name=filer -winwidth=40<CR>

augroup MyVimFilerSettings
    autocmd!
    autocmd FileType vimfiler call s:vimfiler_my_settings()
    autocmd VimEnter * if index(s:blacklist, &ft) < 0 && winwidth(0) >= s:min_width | execute "normal [unite]e" | endif
    autocmd BufEnter * if (winnr('$') == 1 && &filetype ==# 'vimfiler') | q | endif
augroup END
