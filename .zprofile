# vim: filetype=zsh

# Load all functions in zfunctions directory lazily
fpath=(${DOTFILES_ROOT}/.zsh/functions $fpath)
for i in $(ls ${DOTFILES_ROOT}/.zsh/functions) ; do
    autoload -U $i
done

export PAGER=less
export LESS='-g -i -M -R -S -W -z-4 -x4'

if (( $+commands[lesspipe.sh] )); then
    export LESSOPEN="| $(which lesspipe.sh) %s 2>&-"
fi

# Tools
if (( $+commands[rbenv] )); then
    eval "$(rbenv init -)"
fi
if (( $+commands[pyenv] )); then
    eval "$(pyenv init -)"
fi
if (( $+commands[nodenv] )); then
    eval "$(nodenv init -)"
fi

if [ -f ~/.zprofile.local ] ; then
    source ~/.zprofile.local
fi
