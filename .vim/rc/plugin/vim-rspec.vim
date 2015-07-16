NeoBundleLazy 'thoughtbot/vim-rspec', {
            \ 'autoload': {'filetypes': ['ruby']},
            \ 'depends'  : 'tpope/vim-dispatch'
            \ }
let s:bundle = neobundle#get('vim-rspec')
function! s:bundle.hooks.on_source(bundle)
   let g:rspec_command = 'Dispatch rspec {spec}'
endfunction
