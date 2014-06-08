NeoBundleLazy 'kchmck/vim-coffee-script',
            \ {'autoload': {'filetypes': ['coffee']}}
augroup CoffeeScript
    autocmd!
    autocmd FileType coffee call s:my_coffee_settings()
augroup END
function! s:my_coffee_settings()
    nnoremap <silent><buffer> <leader>c :<C-u>CoffeeWatch vertical<CR>
    vnoremap <silent><buffer> <leader>c :<C-u>'<,'>CoffeeCompile vertical<CR>
endfunction
