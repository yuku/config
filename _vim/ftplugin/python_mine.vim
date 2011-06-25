"------------------------------------------------------------
" Code Style
"------------------------------------------------------------
setlocal autoindent
setlocal smartindent cinwords=if,elif,else,for,while,try,except,finally,def,class
inoremap # X^H#
setlocal textwidth=79

if v:version >= 703
    setlocal colorcolumn=80
endif

" Run pep8
let g:pep8_map='<leader>8'

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
" Completion
"------------------------------------------------------------
" Turn on completion
setlocal omnifunc=pythoncomplete#Complete
" tags
setlocal tags+=~/.vim/tags/python/python.tags

"------------------------------------------------------------
" Cleaning stuff
"------------------------------------------------------------
function! _CleanPythonCode()
    exe ":retab"
    exe ":%s/ \\+$//e"
endfunction

command! CleanCode call _CleanPythonCode()

autocmd BufWrite *.{py} :CleanCode

"------------------------------------------------------------
" Django
"------------------------------------------------------------
map <leader>dt :set makeprg=python\ manage.py\ test\|:call MakeGreen()<CR>
