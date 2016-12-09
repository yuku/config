for file in split(glob($DOTFILES_ROOT . "/vim/rc/*.vim"), "\n")
  execute "source " . file
endfor

set background=dark
if !$WITHOUT_COLORSCHEME
  colorscheme base16-default-dark
endif

if filereadable("$HOME/.vimrc.local")
  source $HOME/.vimrc.local
endif
