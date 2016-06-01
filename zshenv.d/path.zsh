typeset -U path

path=("$DOTFILES_ROOT/bin" $path)

if [[ -d "$HOME/bin" ]]; then
    path=("$HOME/bin" $path)
fi
