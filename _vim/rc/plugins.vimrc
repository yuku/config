filetype off
filetype plugin indent off

if has('vim_starting')
    set runtimepath+=~/.vim/bundle/neobundle.vim/
endif
let s:neobundle_dir = expand('~/.vim/bundle/')
call neobundle#rc(s:neobundle_dir)

" Let NeoBundle manage NeoBundle
NeoBundleFetch 'Shougo/neobundle.vim'

source $HOME/.vim/rc/plugin/vimproc.vim
source $HOME/.vim/rc/plugin/unite.vim

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
NeoBundle 'vim-scripts/AnsiEsc.vim'
"NeoBundle 'dbext.vim'
NeoBundle 'rhysd/committia.vim'
NeoBundle 'editorconfig/editorconfig-vim'

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

filetype plugin indent on
syntax on

" Installation check
NeoBundleCheck
