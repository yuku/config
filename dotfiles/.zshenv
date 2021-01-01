export CONFIG_ROOT=~/dev/src/github.com/yuku/config

export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8
export OUTPUT_CHARSET=utf-8
export GOPATH=$HOME/dev
export GOBIN=$GOPATH/bin

typeset -U path
path=("$CONFIG_ROOT/bin" $GOBIN $path)

if [[ -d "$HOME/bin" ]]; then
    path=("$HOME/bin" $path)
fi

[ -f ~/.zshenv.local ] && source ~/.zshenv.local
