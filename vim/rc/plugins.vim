call plug#begin('~/.vim/plugged')

" Make sure you use single quotes

Plug 'Lokaltog/vim-easymotion'
Plug 'Shougo/neocomplete.vim'
Plug 'Shougo/neoyank.vim'
Plug 'Shougo/unite.vim' | Plug 'Shougo/neomru.vim' | Plug 'Shougo/unite-outline'
Plug 'Shougo/vimfiler'
Plug 'Shougo/vimproc.vim', { 'do': 'make' }
Plug 'Shougo/vimshell'
Plug 'chriskempson/base16-vim'
Plug 'editorconfig/editorconfig-vim'
Plug 'itchyny/lightline.vim'
Plug 'noprompt/vim-yardoc', { 'for': 'ruby' }
Plug 'othree/html5.vim', { 'for': 'html' }
Plug 'pangloss/vim-javascript', { 'for': 'javascript' }
Plug 'rhysd/clever-f.vim'
Plug 'slim-template/vim-slim', { 'for': 'slim' }
Plug 'tpope/vim-abolish'
Plug 'tpope/vim-endwise'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-markdown', { 'for': 'markdown' }
Plug 'tpope/vim-sensible'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-unimpaired'
Plug 'vim-ruby/vim-ruby', { 'for': 'ruby' }

" Plugins for snippets
Plug 'honza/vim-snippets' | Plug 'Shougo/neosnippet'

" Plugins for Rails projects
Plug 'tpope/vim-bundler'
Plug 'tpope/vim-rails'

" Add plugins to &runtimepath
call plug#end()

" Load all plugin settings
for file in split(glob($DOTFILES_ROOT . "/vim/rc/plugins/*.vim"), "\n")
  execute "source " . file
endfor
