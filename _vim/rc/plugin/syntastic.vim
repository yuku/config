NeoBundle 'scrooloose/syntastic'
let g:syntastic_mode_map = {
            \ 'mode': 'passive',
            \ 'active_filetypes': ['javascript', 'python', 'perl'],
            \ 'passive_filetypes': []
            \ }
let g:syntastic_ruby_checkers = ['rubocop']
let g:syntastic_javascript_checkers = ['jshint']
