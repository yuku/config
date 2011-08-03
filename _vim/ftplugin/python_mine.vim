"------------------------------------------------------------
" Code Style
"------------------------------------------------------------
setlocal smartindent cinwords=if,elif,else,for,while,try,except,finally,def,class
setlocal textwidth=79

if v:version >= 703
    setlocal colorcolumn=80
endif

" run py.test's
nmap <silent><Leader>tf <Esc>:Pytest file<CR>
nmap <silent><Leader>tc <Esc>:Pytest file<CR>
nmap <silent><Leader>tm <Esc>:Pytest file<CR>
nmap <silent><Leader>tn <Esc>:Pytest file<CR>
nmap <silent><Leader>tp <Esc>:Pytest file<CR>
nmap <silent><Leader>te <Esc>:Pytest file<CR>

"------------------------------------------------------------
" Syntax Highlight
"------------------------------------------------------------
let python_highlight_all=1

"------------------------------------------------------------
" Django
"------------------------------------------------------------
map <leader>dt :set makeprg=python\ manage.py\ test\|:call MakeGreen()<CR>
