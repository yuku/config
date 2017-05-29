export DOTFILES_ROOT=~/src/github.com/yuku-t/dotfiles

# {{{1 variables
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8
export OUTPUT_CHARSET=utf-8
export GOPATH=$HOME
export GOBIN=$GOPATH/bin

typeset -U path
path=("$DOTFILES_ROOT/bin" $GOBIN $path)

if [[ -d "$HOME/bin" ]]; then
    path=("$HOME/bin" $path)
fi

[ -f ~/.zshenv.local ] && source ~/.zshenv.local
