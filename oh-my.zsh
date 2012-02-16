#!/usr/bin/env zsh

## oh-my-zsh plugin
#
plugin=(git python ruby rails django node)

## Environment variable configuration
#
export LANG=ja_JP.UTF-8
export LESSCHARSET=utf-8
export OUTPUT_CHARSET=utf-8
export LC_CTYPE=ja_JP.UTF-8

## Backspace key
#
bindkey "^?" backward-delete-char

## History
#
HISTFILE=$HOME/.zsh-history
HISTSIZE=10000
SAVEHIST=10000
setopt hist_ignore_dups
setopt hist_reduce_blanks
setopt hist_no_store
setopt hist_ignore_space
setopt extended_history
setopt share_history
setopt append_history
setopt inc_append_history
setopt hist_verify
autoload history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
bindkey "^P" history-beginning-search-backward-end
bindkey "^N" history-beginning-search-forward-end
bindkey "^R" history-incremental-search-backward
bindkey "^S" history-incremental-search-forward
function history-all { history -E 1 }

# makeのエラー出力に色付け
e_normal=`echo -e "\033[0;30m"`
e_RED=`echo -e "\033[1;31m"`
e_BLUE=`echo -e "\033[1;36m"`
function make() {
    LANG=C command make "$@" 2>&1 | sed -e "s@[Ee]rror:.*@$e_RED&$e_normal@g" -e "s@cannot\sfind.*@$e_RED&$e_normal@g" -e "s@[Ww]arning:.*@$e_BLUE&$e_normal@g"
}
export MYVIMRC='~/code/dotfiles/_vimrc'

# source-highlight による less の色付け
if [ -f `which source-highlight` ]
then
    export LESS='-R'
    export LESSOPEN="| $HOME/.source-highlight/src-hilite-lesspipe.sh %s"
fi

[ -d /usr/local/bin ] && export PATH=/usr/local/bin:$PATH

export GREP_OPTIONS='--color=auto'

## Python
#
[[ -s "$HOME/.pythonrc.py" ]] && export PYTHONSTARTUP=$HOME/.pythonrc.py
[[ -s "$HOME/.pythonbrew/etc/bashrc" ]] && source $HOME/.pythonbrew/etc/bashrc
export NOSE_REDNOSE=1

## Ruby
#
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source $HOME/.rvm/scripts/rvm

## Node
#
[[ -s "$HOME/.nvm/nvm.sh" ]] && source $HOME/.nvm/nvm.sh

## Perl
#
PERL_BADLANG=0; export PERL_BADLANG

## Java
#
export LC_ALL=en

## Git
#
[[ -s "$HOME/.gitignore" ]] && git config --global core.excludesfile $HOME/.gitignore

## alias
#
[ -f $HOME/.zshrc.alias ] && source $HOME/.zshrc.alias

## os depending settings
#
case ${OSTYPE} in
darwin*) # Mac OS X
    [ -f ~/.zshrc.osx ] && source ~/.zshrc.osx
    export PATH=$PATH:/opt/local/bin:/opt/local/sbin/
    export PATH=$PATH:/System/Library/PrivateFrameworks/Apple80211.framework/Versions/A/Resources/
    ;;
linux*)
    [ -f ~/.zshrc.linux ] && source ~/.zshrc.linux
    ;;
esac

## local settings
[ -f $HOME/.zshrc.local ] && source $HOME/.zshrc.local
