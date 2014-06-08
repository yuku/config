filetype off
filetype plugin indent off

if has('vim_starting')
    set runtimepath+=~/.vim/bundle/neobundle.vim/
endif
let s:neobundle_dir = expand('~/.vim/bundle/')
call neobundle#rc(s:neobundle_dir)

" Let NeoBundle manage NeoBundle
NeoBundleFetch 'Shougo/neobundle.vim'

source $HOME/.vim/plugin/vimproc.vim
source $HOME/.vim/plugin/unite.vim

if has('lua')
    "source $HOME/.vim/plugin/neocomplete.vim
    source $HOME/.vim/plugin/neosnippet.vim
else
    source $HOME/.vim/plugin/neocomplcache.vim
endif

source $HOME/.vim/plugin/vimfiler.vim
"source $HOME/.vim/plugin/vim-ref.vim
source $HOME/.vim/plugin/vim-localrc.vim
"source $HOME/.vim/plugin/vim-gitgutter.vim
"source $HOME/.vim/plugin/vim-indent-guides.vim
source $HOME/.vim/plugin/vim-easymotion.vim
source $HOME/.vim/plugin/syntastic.vim
source $HOME/.vim/plugin/vim-seek.vim
source $HOME/.vim/plugin/Align.vim

NeoBundle 'tpope/vim-fugitive'
NeoBundle 'tpope/vim-surround'
NeoBundle 'tpope/vim-unimpaired'
NeoBundle 'tpope/vim-rails'
"NeoBundle 'dbext.vim'

source $HOME/.vim/plugin/base16-vim.vim
source $HOME/.vim/plugin/lightline.vim
source $HOME/.vim/plugin/vim-gocode.vim

source $HOME/.vim/plugin/vim-quickrun.vim
source $HOME/.vim/plugin/vim-ref-ri.vim

" filetype plugins
"source $HOME/.vim/plugin/hatena-vim.vim
"source $HOME/.vim/plugin/less.vim
"source $HOME/.vim/plugin/perl.vim
"source $HOME/.vim/plugin/typescript-vim.vim
"source $HOME/.vim/plugin/vim-puppet.vim
"source $HOME/.vim/plugin/xslate-vim.vim
"source $HOME/.vim/plugin/zencoding-vim.vim
source $HOME/.vim/plugin/html5.vim
source $HOME/.vim/plugin/vim-jade.vim
source $HOME/.vim/plugin/vim-markdown.vim
source $HOME/.vim/plugin/nginx.vim
source $HOME/.vim/plugin/ruby-matchit.vim
source $HOME/.vim/plugin/scss-syntax.vim
source $HOME/.vim/plugin/vim-coffee-script.vim
source $HOME/.vim/plugin/vim-javascript.vim
source $HOME/.vim/plugin/vim-jst.vim
source $HOME/.vim/plugin/vim-rspec.vim
source $HOME/.vim/plugin/vim-ruby.vim
source $HOME/.vim/plugin/vim-slim.vim

filetype plugin indent on
syntax on

" Installation check
NeoBundleCheck
