call plug#begin('~/.vim/plugged')

" Make sure you use single quotes

Plug 'Lokaltog/vim-easymotion'
Plug 'Shougo/neocomplete.vim'
Plug 'Shougo/neoyank.vim'
Plug 'Shougo/unite.vim' | Plug 'Shougo/neomru.vim' | Plug 'Shougo/unite-outline'
Plug 'Shougo/vimfiler'
Plug 'Shougo/vimproc.vim', { 'do': 'make' }
Plug 'Shougo/vimshell'
Plug 'SirVer/ultisnips' | Plug 'honza/vim-snippets'
" Plug 'Valloric/YouCompleteMe', { 'do': './install.py --tern-completer' }
Plug 'airblade/vim-gitgutter'
Plug 'briancollins/vim-jst', { 'for': 'jst' }
Plug 'chriskempson/base16-vim'
Plug 'editorconfig/editorconfig-vim'
Plug 'fatih/vim-go'
Plug 'flowtype/vim-flow', { 'for': 'javascript.jsx' }
Plug 'itchyny/lightline.vim'
" Plug 'kana/vim-textobj-user' | Plug 'kana/vim-textobj-indent'
Plug 'kana/vim-textobj-user' | Plug 'rhysd/vim-textobj-ruby', { 'for': 'ruby' }
Plug 'kchmck/vim-coffee-script', { 'for': 'coffee' }
Plug 'leafgarland/typescript-vim'
Plug 'mxw/vim-jsx', { 'for': 'javascript' }
Plug 'noprompt/vim-yardoc', { 'for': 'ruby' }
Plug 'othree/html5.vim', { 'for': 'html' }
Plug 'pangloss/vim-javascript', { 'for': 'javascript' }
" Plug 'rhysd/clever-f.vim'
Plug 'scrooloose/syntastic'
Plug 'slim-template/vim-slim', { 'for': 'slim' }
Plug 'tpope/vim-abolish'
" Plug 'tpope/vim-bundler', { 'for': 'ruby' }
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-endwise'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-markdown', { 'for': 'markdown' }
Plug 'tpope/vim-rails'
Plug 'tpope/vim-sensible'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-unimpaired'
Plug 'vim-ruby/vim-ruby'

" Add plugins to &runtimepath
call plug#end()

" Load all plugin settings
for file in split(glob($DOTFILES_ROOT . "/vim/rc/plugins/*.vim"), "\n")
  execute "source " . file
endfor
