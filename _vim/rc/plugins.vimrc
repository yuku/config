filetype off
filetype plugin indent off

if has('vim_starting')
    set runtimepath+=~/.vim/bundle/neobundle.vim/
endif
call neobundle#begin(expand('~/.vim/bundle/'))

" Let NeoBundle manage NeoBundle
NeoBundleFetch 'Shougo/neobundle.vim'

source $HOME/.vim/rc/plugin/vimproc.vim
NeoBundle 'Shougo/unite.vim'
"NeoBundle 'yuku-t/unite-git'
NeoBundle 'Shougo/unite-outline'
"NeoBundle 'Shougo/unite-help'
"NeoBundle 'joker1007/unite-pull-request', { 'depends': 'mattn/webapi-vim' }
NeoBundle 'basyura/unite-rails'
NeoBundle 'Shougo/neomru.vim'

if has('lua')
    source $HOME/.vim/rc/plugin/neocomplete.vim
    source $HOME/.vim/rc/plugin/neosnippet.vim
else
    source $HOME/.vim/rc/plugin/neocomplcache.vim
endif

source $HOME/.vim/rc/plugin/vimfiler.vim
source $HOME/.vim/rc/plugin/vim-gitgutter.vim
source $HOME/.vim/rc/plugin/vim-indent-guides.vim
source $HOME/.vim/rc/plugin/vim-easymotion.vim
source $HOME/.vim/rc/plugin/syntastic.vim
NeoBundle 'thinca/vim-localrc'
NeoBundle 'goldfeld/vim-seek'
NeoBundle 'Align'
NeoBundle 'rhysd/clever-f.vim'

NeoBundle 'tomtom/tcomment_vim'
NeoBundle 'tpope/vim-fugitive'
NeoBundle 'tpope/vim-surround'
NeoBundle 'tpope/vim-unimpaired'
NeoBundle 'tpope/vim-rails'
NeoBundle 'tpope/vim-abolish'
NeoBundle 'vim-scripts/AnsiEsc.vim'
"NeoBundle 'dbext.vim'
NeoBundle 'rhysd/committia.vim'
NeoBundle 'editorconfig/editorconfig-vim'
NeoBundle 'tmux-plugins/vim-tmux-focus-events'

source $HOME/.vim/rc/plugin/base16-vim.vim
source $HOME/.vim/rc/plugin/lightline.vim
source $HOME/.vim/rc/plugin/vim-gocode.vim

source $HOME/.vim/rc/plugin/vim-quickrun.vim
" source $HOME/.vim/rc/plugin/vim-ref-ri.vim

" filetype plugins
source $HOME/.vim/rc/plugin/vim-coffee-script.vim
source $HOME/.vim/rc/plugin/vim-rspec.vim
source $HOME/.vim/rc/plugin/vim-slim.vim
NeoBundleLazy 'othree/html5.vim', {
            \ 'autoload': {'filetypes': ['html']}
            \ }
NeoBundleLazy 'digitaltoad/vim-jade', {
            \ 'autoload': {'filetypes': ['jade']}
            \ }
NeoBundleLazy 'tpope/vim-markdown', {
            \ 'autoload': {'filetypes': ['markdown']}
            \ }
NeoBundleLazy 'nginx.vim', {
            \ 'autoload': {'filetypes': ['nginx']}
            \ }
NeoBundleLazy 'ruby-matchit', {
            \ 'autoload': {'filetypes': ['ruby', 'eruby', 'haml']}
            \ }
NeoBundleLazy 'cakebaker/scss-syntax.vim', {
            \ 'autoload': {'filetypes': ['scss']}
            \ }
NeoBundleLazy 'pangloss/vim-javascript', {
            \ 'autoload': {'filetypes': ['javascript']}
            \ }
NeoBundleLazy 'briancollins/vim-jst', {
            \ 'autoload': {'filetypes': ['jst', 'ejs']},
            \ 'depends': 'pangloss/vim-javascript'
            \ }
NeoBundleLazy 'vim-ruby/vim-ruby', {
            \ 'autoload': {'filetypes': ['ruby', 'eruby', 'haml']}
            \ }
NeoBundleLazy 'tpope/vim-endwise', {
            \ 'autoload': {'filetypes': ['ruby']}
            \ }
NeoBundleLazy 'noprompt/vim-yardoc', {
            \ 'autoload': {'filetypes': ['ruby']}
            \ }

NeoBundle 'leafgarland/typescript-vim'
NeoBundleLazy 'clausreinke/typescript-tools', {
            \ 'autoload': {'filetypes': ['typescript']}
            \ }
NeoBundleLazy 'alunny/pegjs-vim', {
            \ 'autoload': {'filetypes': ['pegjs']}
            \ }

call neobundle#end()

filetype plugin indent on
syntax on


" Unite  {{{
" -----

" default profile
call unite#custom#profile('default', 'context', {
      \ 'winwidth': 50,
      \ 'start_insert': 1
      \ })
" ctrlp.vim like behavior
call unite#custom#profile('ctrlp', 'context', {
      \ 'start_insert': 1,
      \ 'winheight': 20,
      \ 'direction': 'botright',
      \ 'buffer_name': 'async'
      \ })
call unite#custom#source('file_rec/async,file_rec/git', 'ignore_pattern',
      \ '\v\/doc\/|.vagrant|.git\/|\/cache\/|.(png|gif|jpeg|jpg)$'
      \ )
function! DispatchUniteFileRecAsyncOrGit()
  if isdirectory(getcwd()."/.git")
    " If current dir is root git directory.
    Unite -profile-name=ctrlp file_rec/git
  else
    Unite -profile-name=ctrlp file_rec/async:!
  endif
endfunction
nnoremap <silent> <C-p> :<C-u>call DispatchUniteFileRecAsyncOrGit()<CR>

if executable('ag')
    let g:unite_source_grep_command = 'ag'
    let g:unite_source_grep_default_opts = '--nogroup --nocolor --column'
    let g:unite_source_grep_recursive_opt = ''
endif

" The prefix key.
nnoremap [unite]  <Nop>
nmap     <space>  [unite]

" unite/rails settings
" --------------------
nnoremap <silent> [unite]p :<C-u>Unite -profile-name=ctrlp source<CR>rails/

" neomru
" ------
"call unite#custom#source('file_mru', 'matchers', '.*\/$\|.*Application\ Data.*')
nnoremap <silent> [unite]m :<C-u>Unite -quick-match -profile-name=ctrlp neomru/file<CR>

nnoremap <silent> [unite]u :<C-u>UniteWithBufferDir
            \ -buffer-name=files file file/new<CR>
nnoremap <silent> [unite]c :<C-u>UniteWithCurrentDir
            \ -buffer-name=files -prompt=%\ buffer bookmark file file/new<CR>
nnoremap <silent> [unite]/ :<C-u>Unite grep:.<CR>
let g:unite_source_history_yank_enable = 1
nnoremap <silent> [unite]y :<C-u>Unite history/yank<CR>
nnoremap <silent> [unite]b :<C-u>Unite -quick-match buffer<CR>
"nnoremap <silent> [unite]h :<C-u>Unite help<CR>
nnoremap <silent> [unite]t :<C-u>Unite
            \ -no-start-insert -immediately tab:no-current<CR>
nnoremap <silent> [unite]w :<C-u>Unite
            \ -no-start-insert -immediately window:no-current<CR>
nnoremap <silent> [unite]o :<C-u>Unite
            \ -vertical -no-quit -toggle -direction=botright
            \ -buffer-name=outline -winwidth=40 outline<CR>

augroup UniteFileType
    autocmd!
"    autocmd FileType vim    nnoremap <silent><buffer> K :<C-u>Unite -start-insert -default-action=vsplit help<CR>
"    autocmd FileType sh     nnoremap <silent><buffer> K :<C-u>Unite -start-insert -default-action=vsplit ref/man<CR>
"    autocmd FileType erlang nnoremap <silent><buffer> K :<C-u>Unite -start-insert -default-action=vsplit ref/erlang<CR>
"    autocmd FileType ruby   nnoremap <silent><buffer> K :<C-u>Unite -start-insert -default-action=vsplit ref/ri<CR>
"    autocmd FileType python nnoremap <silent><buffer> K :<C-u>Unite -start-insert -default-action=vsplit ref/pydoc<CR>
"    autocmd FileType perl   nnoremap <silent><buffer> K :<C-u>Unite -start-insert -default-action=vsplit ref/perldoc<CR>
"
    autocmd FileType unite call s:unite_my_settings()
augroup END

function! s:unite_my_settings()
    " Overwrite settings
    nmap <buffer><ESC>  <Plug>(unite_exit)
    nmap <buffer><C-c>  <Plug>(unite_exit)
    nmap <buffer><C-x>  <Plug>(unite_redraw)
    "imap <buffer>jj     <Plug>(unite_insert_leave)
    imap <buffer><C-w>  <Plug>(unite_delete_backward_path)

    " <C-l>: manual neocomplete completion.
    "inoremap <buffer><C-l>  <C-x><C-u><C-p><Down>

    nmap <buffer><expr><C-d>  unite#do_action('delete')
    imap <buffer><expr><C-d>  unite#do_action('delete')
    nmap <buffer><expr><C-b>  unite#do_action('bookmark')
    imap <buffer><expr><C-b>  unite#do_action('bookmark')
    nmap <buffer><expr><C-k>  unite#do_action('above')
    imap <buffer><expr><C-k>  unite#do_action('above')
    nmap <buffer><expr><C-i>  unite#do_action('left')
    imap <buffer><expr><C-i>  unite#do_action('left')
endfunction

" }}}

colorscheme base16-default

" Installation check
NeoBundleCheck
