for file in split(glob($DOTFILES_ROOT . "/vim/rc/*.vim"), "\n")
  execute "source " . file
endfor

if filereadable(expand("~/.vimrc_background"))
  let base16colorspace=256
  source ~/.vimrc_background
endif

if filereadable("$HOME/.vimrc.local")
  source $HOME/.vimrc.local
endif
