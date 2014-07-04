NeoBundle 'scrooloose/syntastic'
let g:syntastic_error_symbol = '✗'
let g:syntastic_style_error_symbol = '✗'
let g:syntastic_warning_symbol = '⚠'
let g:syntastic_style_warning_symbol = '⚠'
let g:syntastic_mode_map = {
            \ 'mode': 'passive',
            \ 'active_filetypes': ['javascript', 'python', 'perl'],
            \ 'passive_filetypes': []
            \ }
let g:syntastic_ruby_checkers = ['rubocop']
let g:syntastic_ruby_rubocop_args = '--rails --auto-correct'
let g:syntastic_javascript_checkers = ['jshint']

augroup SyntasticFileChange
    au!
    au FileChangedShell *.rb e
augroup END
