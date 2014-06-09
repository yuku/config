NeoBundleLazy 'thinca/vim-quickrun',      {
      \   'autoload': {
      \     'filetypes': ['ruby', 'python', 'perl', 'sh', 'go']
      \   }
      \ }
nmap <Leader>r <plug>(quickrun)
let g:quickrun_config = {
            \ 'go': {
            \   'command': 'go',
            \   'exec': ['%c run %s']
            \ }
            \}
"let g:quickrun_config.perl = {'command': 'perl', 'cmdopt': '-MProject::Libs'}
