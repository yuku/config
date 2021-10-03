# vim: filetype=zsh

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

# Tools

if [ -f ~/.zprofile.local ] ; then
    source ~/.zprofile.local
fi
