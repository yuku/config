#----------------------------------------------------------#
#                                                          #
#                         $$\                              #
#                         $$ |                             #
#     $$$$$$$$\  $$$$$$$\ $$$$$$$\   $$$$$$\   $$$$$$$\    #
#     \____$$  |$$  _____|$$  __$$\ $$  __$$\ $$  _____|   #
#       $$$$ _/ \$$$$$$\  $$ |  $$ |$$ |  \__|$$ /         #
#      $$  _/    \____$$\ $$ |  $$ |$$ |      $$ |         #
#     $$$$$$$$\ $$$$$$$  |$$ |  $$ |$$ |      \$$$$$$$\    #
#     \________|\_______/ \__|  \__|\__|       \_______|   #
#                                                          #
#----------------------------------------------------------#

# This file sets up cli environment.

# Load Functions {{{1
# ===================

if [ -d "$HOME/.zsh/functions" ] ; then
  # Enable to autoload functions in ~/.zsh/functions
  fpath=($HOME/.zsh/functions(N-/) $fpath)

  # Load all functions lazily
  for i in $(ls $HOME/.zsh/functions) ; do autoload -U $i ; done
fi

for i (.zsh/completions .zsh/zsh-completions/src .go/src/github.com/motemen/ghq/zsh) ; do
  [ -d "$HOME/$i" ] && fpath=("$HOME/$i" $fpath)
done

autoload -U colors
autoload -Uz compinit
autoload -Uz url-quote-magic
autoload -Uz chpwd_recent_dirs cdr add-zsh-hook # Activate cdr command for zaw-cdr

# General Settings {{{1
# ==========================

export EDITOR=vim
export GREP_OPTIONS='--color=auto'
export LANG=ja_JP.UTF-8
export LESSCHARSET=utf-8
# export MYSQL_PS1='(^[[32m\u^[[00m@^[[33m\h^[[00m) ^[[34m[\d]^[[00m > '
export OUTPUT_CHARSET=utf-8

# zshparam
HISTFILE=$HOME/.zsh-history        # History file
HISTSIZE=10000                     # Number of saved history on memory
REPORTTIME=3                       # Output statistics of slow command
SAVEHIST=10000                     # Number of saved history
WORDCHARS='*?_-.[]~=&;!#$%^(){}<>' # C-w deletes the caractor next to the /

set bell-style none; setopt nobeep; setopt nolistbeep # No beep

setopt append_history
setopt auto_cd              # Change direcroty with it's name
setopt auto_list            # Show all candidates
setopt auto_menu            # Toggle complement candidates using TAB
setopt auto_param_slash     # Insert / after a complemented directory name
setopt auto_pushd           # Execute pushd command when current directory is changed by cd command
setopt checkjobs            # Check background job when logging out
setopt complete_aliases     # Expand aliases before completing
setopt correct              # Do spell check
setopt extended_history     # Current time is also saved
setopt hist_ignore_all_dups # Ignore duplicated history
setopt hist_ignore_space    # Ignore command starts with white spaces
setopt hist_no_store        # Ignore history command
setopt hist_reduce_blanks   # Strip white spaces
setopt hist_verify          # Can edit history before execute it
setopt inc_append_history
setopt interactive_comments # Ignore commands following # in cui
setopt list_packed          # Use compackt style candidates viewer mode
setopt list_types           # Show kinds of file using marks
setopt magic_equal_subst    # Even option args are complemented
setopt no_flow_control      # Disable C-s and C-q
setopt no_hup               # Keep processs when logging out
setopt noautoremoveslash    # Don't automatically remove / on the tail
setopt noclobber            # Prevents accidentally overwriting an existing file.
setopt notify               # Immediately notify when backgroung job finishes
setopt print_eight_bit      # Enable Japanese file name
setopt prompt_subst         # Use escape sequences
setopt pushd_ignore_dups    # Make pushd command ignore duplicated directories
setopt pushd_silent         # Do not print the directory stack after popd
setopt share_history        # Share history across multi processes
setopt transient_rprompt

umask 022                   # Default umask

# Widgets {{{1
# ============

autoload history-search-end
zle -N git_fetch
zle -N git_pull_current_branch_from_origin
zle -N git_status
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
zle -N self-insert url-quote-magic # Automatically escape URL string

# Alias {{{1
# ==========

alias -g G='|grep'
alias -g GI='|grep -i'
alias -g H='|head'
alias -g L='|less'
alias -g T='|tail'
alias -s {gz,tgz,zip,lzh,bz2,tbz,Z,tar,arj,xz}=extract
alias df='df -h'
alias du='du -h'
alias gbr='command git branch'
alias gcc='gcc -Wall -lstdc++'
alias gci='command git commit -v'
alias gco='command git checkout'
alias ggp='command git grep -H --heading --break'
alias glg='command git log --graph --pretty="format:%C(yellow)%h%C(blue)%d%C(reset) %s %C(cyan)%an, %ar%C(reset)"'
alias gst='command git status --short'
alias gun='command git reset HEAD~'
alias hg='hg --encoding=utf-8'
alias inflate="perl -MCompress::Zlib -e 'undef $/; print uncompress(<>)'"
alias java='java -Dfile.encoding=UTF-8'
alias javac='javac -J-Dfile.encoding=UTF-8'
alias la='ls -A'
alias ll='ls -lh'
alias lla='ls -lhA'
alias lsd='ls -ld *(-/DN)'
alias sudo='env PATH=${PATH}:/sbin:/usr/sbin:/usr/local/sbin \sudo'

## OS depending
case ${OSTYPE} in
darwin*) # Mac OS X
  alias ls='ls -GF'
  alias -s {png,jpg,bmp,PNG,JPG,BMP}='open -a Preview'
  alias pong='perl -nle '\''print "display notification \"$_\" with title \"Terminal\""'\'' | osascript'
  export PATH="/usr/local/sbin:$PATH"
  ;;
linux*)
  alias ls='ls -F --color=auto'
  ;;
esac

if [ -x "$(which grc 2> /dev/null)" ] ; then
  #alias ifconfig='grc ifconfig'
  alias dig='grc dig'
  alias ldap='grc ldap'
  alias netstat='grc netstat'
  alias ping='grc ping'
  alias ps='grc ps'
  alias traceroute='grc traceroute'
  alias gcc='grc gcc'
fi

[ -x "$(which colordiff 2> /dev/null)" ] && alias diff='colordiff'
[ -x "$(which hub 2> /dev/null)" ]       && eval "$(hub alias -s)"     # use hub
[ -x "$(which direnv 2> /dev/null)" ]    && eval "$(direnv hook zsh)"  # use direnv

# Keybindings {{{1
# ================

bindkey -e # emacs like keybinding. Must call before following bindkey settings.

bindkey '^G^F' git_fetch
bindkey '^G^P' git_pull_current_branch_from_origin
bindkey '^G^S' git_status
bindkey '^N'   history-beginning-search-forward-end
bindkey '^O^B' zaw-git-recent-branches
bindkey '^O^R' zaw-git-branches
bindkey '^P'   history-beginning-search-backward-end
bindkey '^R'   zaw-history
bindkey '^T'   zaw-cdr

# Prompt {{{1
# ===========
colors

local DEFAULT=$'%{\e[1;0m%}'
local RESET="%{${reset_color}%}"
local GREEN="%{${fg[green]}%}"
local BLUE="%{${fg[blue]}%}"
local RED="%{${fg[red]}%}"
local CYAN="%{${fg[cyan]}%}"
local YELLOW="%{${fg[yellow]}%}"
local WHITE="%{${fg[white]}%}"
local GRAY="%{${fg[gray]}%}"
local BOLD_GREEN="%{${fg_bold[green]}%}"
local BOLD_BLUE="%{${fg_bold[blue]}%}"
local BOLD_RED="%{${fg_bold[red]}%}"
local BOLD_CYAN="%{${fg_bold[cyan]}%}"
local BOLD_YELLOW="%{${fg_bold[yellow]}%}"
local BOLD_WHITE="%{${fg_bold[white]}%}"
local BOLD_GRAY="%{${fg_bold[gray]}%}"

function precmd () {
    local color branch
    PROMPT="${GREEN}%n${RESET}@${BLUE}%m${YELLOW} %~${RESET} "
    # PROMPT="${YELLOW}%~${RESET} "
    if [ "$(is_git_repository)" = 'true' ] ; then
        st=`command git status 2>/dev/null`
        if [ $? ] ; then
            if [[ -n `echo "$st" | grep "^nothing to"` ]] ; then
                color=$CYAN
            elif [[ -n `echo "$st" | grep "^nothing added"` ]] ; then
                color=$BLUE
            elif [[ -n `echo "$st" | grep "^# Untracked"` ]] ; then
                color=$BOLD_RED
            else
                color=$RED
            fi
            branch=$(git current-branch 2> /dev/null)
            if [ $branch ] ; then
                PROMPT+="$color$branch%b${RESET} "
            fi
        fi
    fi
}

# Completion {{{1
# ===============
compinit -u

zstyle ':chpwd:*' recent-dirs-default yes
zstyle ':chpwd:*' recent-dirs-max 5000
zstyle ':completion:*' format '%B%d%b'
zstyle ':completion:*' group-name ''
zstyle ':completion:*' ignore-parents parent pwd # Don't show current directory
zstyle ':completion:*' recent-dirs-insert both
zstyle ':completion:*' verbose yes
zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([%0-9]#)*=0=01;31' # Complement process name with kill command
zstyle ':completion:*:default' menu select=1 # Can use Emacs style keybind to select candidates
zstyle ':completion:*:sudo:*' command-path /usr/local/sbin /usr/local/bin /usr/sbin /usr/bin /sbin/bin
zstyle ':completion:*:warnings' format 'No matches for: %d'
zstyle ':filter-select' case-insensitive yes
zstyle ':filter-select' max-lines $(($LINES / 2))


# Third Parties {{{1
# ==================

for i (
  $HOME/.zsh/zaw/zaw.zsh
  $HOME/.zsh/zaw-sources/git-recent-branches.zsh
  $HOME/.zsh/zaw-sources/zaw-git-show-branch.zsh
  $HOME/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
)
do
  [ -f $i ] && source $i
done

add-zsh-hook chpwd chpwd_recent_dirs

# Local settings {{{1
[ -f ~/.zshrc.local ] && source ~/.zshrc.local

test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"
