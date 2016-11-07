export PAGER=less
export LESS='-g -i -M -R -S -W -z-4 -x4'

if (( $+commands[lesspipe.sh] )); then
    export LESSOPEN="| $(which lesspipe.sh) %s 2>&-"
fi
