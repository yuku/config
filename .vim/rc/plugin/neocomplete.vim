NeoBundle 'Shougo/neocomplete'
" Use neocomplete.
let g:neocomplete#enable_at_startup = 1
" Use smartcase.
let g:neocomplete#enable_smart_case = 1
" Use camel case completion.
let g:neocomplete#enable_camel_case = 1
" Supress some errors.
let g:neocomplete#force_overwrite_completefunc = 1
" Set minimum syntax keyword length.
let g:neocomplete#sources#syntax#min_keyword_length = 3
let g:neocomplete#lock_buffer_name_pattern = '\*ku\*'
" The number of candidates displayed in a pop-up menu.
let g:neocomplete#max_list = 10

" Define dictionary.
let g:neocomplete#sources#dictionary#dictionaries = {
            \ 'perl'       : $HOME.'/.vim/dict/perl.dict',
            \ 'javascript' : $HOME.'/.vim/dict/javascript.dict',
            \ 'coffee'     : $HOME.'/.vim/dict/javascript.dict',
            \ 'gitcommit'  : $HOME.'/.vim/dict/gitcommit.dict'
            \ }

" Define keyword.
if !exists('g:neocomplete_keyword_patterns')
    let g:neocomplete#keyword_patterns = {}
endif
let g:neocomplete#keyword_patterns['default'] = '\h\w*'

" Plugin key-mappings.
inoremap <expr><C-g>  neocomplete#undo_completion()
"inoremap <expr><C-l>  neobundle#complete_common_string()

" Recommended key-mappings.
" <CR>: close popup and save indent.
inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
function! s:my_cr_function()
    return neocomplete#smart_close_popup() . "\<CR>"
    " For no inserting <CR> key.
    "return pumvisible() ? neocomplete#close_popup() : "\<CR>"
endfunction
" <TAB>: compleion.
inoremap <expr><TAB> pumvisible() ? "\<C-n>" : "\<TAB>"
" <C-h>, <BS>: close popup and delete backword char.
inoremap <expr><C-h> neocomplete#smart_close_popup()."\<C-h>"
inoremap <expr><BS>  neocomplete#smart_close_popup()."\<C-h>"
inoremap <expr><C-y> neocomplete#close_popup()
inoremap <expr><C-e> neocomplete#cancel_popup()
" <Space>: close popup.
"inoremap <expr><Space> pumvisible() ? neocomplete#close_popup() : "\<Space>"

" Enable omni completion.
augroup OmniCompletion
    autocmd!
    autocmd FileType css
            \ setlocal omnifunc=csscomplete#CompleteCSS
    autocmd FileType html,markdown,slim
            \ setlocal omnifunc=htmlcomplete#CompleteTags
    autocmd FileType javascript
            \ setlocal omnifunc=javascriptcomplete#CompleteJS
    autocmd FileType python
            \ setlocal omnifunc=pythoncomplete#Complete
    autocmd FileType xml
            \ setlocal omnifunc=xmlcomplete#CompleteTags
augroup END
" Ruby omni completion.
NeoBundle 'supermomonga/neocomplete-rsense.vim'
