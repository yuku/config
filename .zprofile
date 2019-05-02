# Load all functions in zfunctions directory lazily
fpath=(${DOTFILES_ROOT}/.zsh/functions $fpath)
for i in $(ls ${DOTFILES_ROOT}/.zsh/functions) ; do
    autoload -U $i
done

# {{{1 Variables
export PAGER=less
export LESS='-g -i -M -R -S -W -z-4 -x4'

if (( $+commands[lesspipe.sh] )); then
    export LESSOPEN="| $(which lesspipe.sh) %s 2>&-"
fi

# vim: filetype=zsh
