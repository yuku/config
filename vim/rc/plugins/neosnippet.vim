" Don't use Shougo/neosnippet-snippets
let g:neosnippet#disable_runtime_snippets = {
      \   '_' : 1,
      \ }

imap <C-k> <Plug>(neosnippet_expand_or_jump)
smap <C-k> <Plug>(neosnippet_expand_or_jump)
xmap <C-k> <Plug>(neosnippet_expand_or_jump)
