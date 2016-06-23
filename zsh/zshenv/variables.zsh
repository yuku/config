export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8
export OUTPUT_CHARSET=utf-8
export GOPATH=$HOME/.go
export GOBIN=$GOPATH/bin

typeset -U path
path=("$DOTFILES_ROOT/bin" $GOBIN $path)

if [[ -d "$HOME/bin" ]]; then
    path=("$HOME/bin" $path)
fi
