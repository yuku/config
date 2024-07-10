export CONFIG_ROOT=~/dev/src/github.com/yuku/config

export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8
export OUTPUT_CHARSET=utf-8
export GOPATH=$HOME/dev
export GOBIN=$GOPATH/bin

typeset -U path
path=("$CONFIG_ROOT/bin" $GOBIN $path)

# Load all functions in zfunctions directory lazily
fpath=(${CONFIG_ROOT}/dotfiles/.zsh/functions $fpath)
for i in $(ls ${CONFIG_ROOT}/dotfiles/.zsh/functions) ; do
    autoload -U $i
done

export PAGER=less
export LESS='-g -i -M -R -S -W -z-4 -x4'

if (( $+commands[lesspipe.sh] )); then
    export LESSOPEN="| $(which lesspipe.sh) %s 2>&-"
fi

if [[ -d "$HOME/bin" ]]; then
    path=("$HOME/bin" $path)
fi

[ -f ~/.zshenv.local ] && source ~/.zshenv.local
