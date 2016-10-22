for file in split(glob($DOTFILES_ROOT . "/vim/rc/*.vim"), "\n")
  execute "source " . file
endfor

set background=dark
colorscheme base16-default-dark

if exists("$HOME/.vimrc.local")
  source $HOME/.vimrc.local
endif
