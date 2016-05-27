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
Plug 'rhysd/clever-f.vim'
Plug 'tpope/vim-abolish'
Plug 'tpope/vim-endwise'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-sensible'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-unimpaired'

" Plugins for snippets
Plug 'honza/vim-snippets' | Plug 'Shougo/neosnippet'

" Plugins for Rails projects
Plug 'tpope/vim-bundler'
Plug 'tpope/vim-rails'

" Add plugins to &runtimepath
call plug#end()

" Load all plugin settings
for file in split(glob($DOTFILES_DIR . "/vim/rc/plugins/*.vim"), "\n")
  execute "source " . file
endfor
