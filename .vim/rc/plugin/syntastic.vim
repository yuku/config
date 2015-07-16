" NeoBundle 'scrooloose/syntastic'
let g:syntastic_error_symbol = '✗'
let g:syntastic_style_error_symbol = '✗'
let g:syntastic_warning_symbol = '⚠'
let g:syntastic_style_warning_symbol = '⚠'
" let g:syntastic_mode_map = {
"             \ 'mode': 'passive',
"             \ 'active_filetypes': ['javascript', 'python', 'perl', 'scss'],
"             \ 'passive_filetypes': []
"             \ }
let g:syntastic_ruby_checkers = ['rubocop']
let g:syntastic_javascript_checkers = ['jshint']
let g:syntastic_scss_checkers = ['scss_lint']
let g:syntastic_coffee_checkers = ['coffeelint']
