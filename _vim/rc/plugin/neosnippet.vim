NeoBundle 'Shougo/neosnippet'
let g:neosnippet#snippets_directory =
        \ '~/.vim/snippets,~/.vim/bundle/snipmate-snippets/snippets'

" Key mapping.
inoremap <C-k>        <Plug>(neosnippet_expand_or_jump)
snoremap <C-k>        <Plug>(neosnippet_expand_or_jump)
xnoremap <C-k>        <Plug>(neosnippet_expand_target)
xnoremap <C-l>        <Plug>(neosnippet_start_unite_snippet_target)

" For snippet_complete marker.
if has('conceal')
    set conceallevel=2 concealcursor=i
endif
