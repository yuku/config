# Enable zsh version conditional branch.
autoload -Uz is-at-least

# {{{1 variables
export ZPLUG_HOME=${CONFIG_ROOT}/modules/zplug

# {{{1 General
export EDITOR=nvim
export GREP_OPTIONS='--color=auto'
export LESSCHARSET=utf-8
REPORTTIME=3                       # Output statistics of slow command
WORDCHARS='*?_-.[]~=&;!#$%^(){}<>' # C-w deletes the caractor next to the /

autoload -Uz url-quote-magic

set bell-style none; setopt nobeep; setopt nolistbeep # No beep

setopt auto_cd              # Change direcroty with it's name
setopt auto_pushd           # Execute pushd command when current directory is changed by cd command
setopt checkjobs            # Check background job when logging out
setopt complete_aliases     # Expand aliases before completing
setopt interactive_comments # Ignore commands following # in cui
setopt no_flow_control      # Disable C-s and C-q
setopt no_hup               # Keep processs when logging out
setopt noautoremoveslash    # Don't automatically remove / on the tail
setopt noclobber            # Prevents accidentally overwriting an existing file.
setopt notify               # Immediately notify when backgroung job finishes
setopt print_eight_bit      # Enable Japanese file name
setopt prompt_subst         # Use escape sequences
setopt pushd_ignore_dups    # Make pushd command ignore duplicated directories
setopt pushd_silent         # Do not print the directory stack after popd
setopt transient_rprompt

umask 022                   # Default umask

# {{{1 Alias
alias -g G='|grep'
alias -g GI='|grep -i'
alias -g H='|head'
alias -g L='|less'
alias -g T='|tail'
alias -s {gz,tgz,zip,lzh,bz2,tbz,Z,tar,arj,xz}=extract
alias strip-color="perl -MTerm::ANSIColor=colorstrip -ne 'print colorstrip(\$_)'"
alias df='df -h'
alias du='du -h'
alias glg='command git log --graph --pretty="format:%C(yellow)%h%C(blue)%d%C(reset) %s %C(cyan)%an, %ar%C(reset)"'
alias hg='hg --encoding=utf-8'
alias inflate="perl -MCompress::Zlib -e 'undef $/; print uncompress(<>)'"
alias java='java -Dfile.encoding=UTF-8'
alias javac='javac -J-Dfile.encoding=UTF-8'
alias la='ls -A'
alias ll='ls -lh'
alias lla='ls -lhA'
alias lsd='ls -ld *(-/DN)'
alias sudo='env PATH=${PATH}:/sbin:/usr/sbin:/usr/local/sbin \sudo'

case ${OSTYPE} in
darwin*)
    alias ls='ls -GF'
    alias -s {png,jpg,jpeg,bmp,PNG,JPG,JPEG,BMP}='open -a Preview'
    alias pong='perl -nle '\''print "display notification \"$_\" with title \"Terminal\""'\'' | osascript'
    alias -g P='|pbcopy'
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

if (( $+commands[colordiff] )); then
    alias diff='colordiff'
fi

# {{{1 Completion
autoload -Uz compinit; compinit -u

setopt auto_list            # Show all candidates
setopt auto_menu            # Toggle complement candidates using TAB
setopt auto_param_slash     # Insert / after a complemented directory name
setopt correct              # Do spell check
setopt list_packed          # Use compackt style candidates viewer mode
setopt list_types           # Show kinds of file using marks
setopt magic_equal_subst    # Even option args are complemented

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

# {{{1 History
HISTFILE=$HOME/.zsh-history        # History file
HISTSIZE=10000                     # Number of saved history on memory
SAVEHIST=10000                     # Number of saved history

setopt append_history
setopt extended_history     # Current time is also saved
setopt hist_ignore_all_dups # Ignore duplicated history
setopt hist_ignore_space    # Ignore command starts with white spaces
setopt hist_no_store        # Ignore history command
setopt hist_reduce_blanks   # Strip white spaces
setopt hist_verify          # Can edit history before execute it
setopt inc_append_history
setopt share_history        # Share history across multi processes

# {{{1 Style
# {{{2 Prompt
autoload -U colors
colors

function squashed_pwd() {

    echo "$(pwd | sed -e "s:^$HOME:~:" | ruby -pe "gsub(%r{([^/]+)/}) { \"#{\$1[0]}/\" }")"
}

function precmd () {
    local color branch st
    local default=$'%{\e[1;0m%}'
    local reset="%{${reset_color}%}"
    local green="%{${fg[green]}%}"
    local blue="%{${fg[blue]}%}"
    local red="%{${fg[red]}%}"
    local cyan="%{${fg[cyan]}%}"
    local yellow="%{${fg[yellow]}%}"
    local white="%{${fg[white]}%}"
    local gray="%{${fg[gray]}%}"
    local bold_green="%{${fg_bold[green]}%}"
    local bold_blue="%{${fg_bold[blue]}%}"
    local bold_red="%{${fg_bold[red]}%}"
    local bold_cyan="%{${fg_bold[cyan]}%}"
    local bold_yellow="%{${fg_bold[yellow]}%}"
    local bold_white="%{${fg_bold[white]}%}"
    local bold_gray="%{${fg_bold[gray]}%}"

    PROMPT="${green}%n${reset}@${blue}%m${yellow} $(squashed_pwd)${reset} "
    # PROMPT="${YELLOW}%~${RESET} "
    branch="$(command git current-branch 2> /dev/null)"
    if [ $branch ] ; then
        st=`command git status 2>/dev/null`
        if [[ -n `echo "$st" | grep "^nothing to"` ]] ; then
            color=$cyan
        elif [[ -n `echo "$st" | grep "^nothing added"` ]] ; then
            color=$blue
        elif [[ -n `echo "$st" | grep "^# untracked"` ]] ; then
            color=$bold_red
        else
            color=$red
        fi
        PROMPT+="${color}${branch}%b${reset} "
    fi
}

# {{{2 Base16
BASE16_SHELL=$CONFIG_ROOT/modules/base16-shell
[ -n "$PS1" ] && [ -s $BASE16_SHELL/profile_helper.sh ] && eval "$($BASE16_SHELL/profile_helper.sh)"
base16_default-dark

# {{{1 SSH agent
# http://qiita.com/sonots/items/2d7950a68da0a02ba7e4
agent="$HOME/.ssh/agent"
if [ -S "$SSH_AUTH_SOCK" ]; then
  case $SSH_AUTH_SOCK in
  /tmp/*/agent.[0-9]*)
    ln -snf "$SSH_AUTH_SOCK" $agent && export SSH_AUTH_SOCK=$agent
  esac
elif [ -S $agent ]; then
  export SSH_AUTH_SOCK=$agent
else
  echo "no ssh-agent"
fi

# {{{1 widgets
autoload history-search-end
zle -N self-insert url-quote-magic # Automatically escape URL string

# {{{1 Plugins
source $ZPLUG_HOME/init.zsh

# Set the priority when loading
# e.g., zsh-syntax-highlighting must be loaded
# after executing compinit command and sourcing other plugins
# (If the defer tag is given 2 or above, run after compinit command)
zplug "zsh-users/zsh-syntax-highlighting", defer:2

zplug "zsh-users/zsh-completions"

zplug "zsh-users/zaw"

# Install plugins if there are plugins that have not been installed
if ! zplug check --verbose; then
    printf "Install? [y/N]: "
    if read -q; then
        echo; zplug install
    fi
fi

# Activate cdr command. Must came before `zplug load`
autoload -Uz chpwd_recent_dirs cdr add-zsh-hook
if is-at-least 4.3.10; then
    add-zsh-hook chpwd chpwd_recent_dirs
    zstyle ':chpwd:*' recent-dirs-default yes
    zstyle ':chpwd:*' recent-dirs-max 5000
fi

# Then, source plugins and add commands to $PATH
zplug load

# {{{1 Keybinding
bindkey -e # emacs like keybinding. Must call before following bindkey settings.

zle -N git-fetch
bindkey '^G^F' git-fetch

zle -N git-pull-current-branch
bindkey '^G^P' git-pull-current-branch

zle -N git-status
bindkey '^G^S' git-status

zle -N git-checkout-pull-request
bindkey '^O^E' git-checkout-pull-request

zle -N peco-src
bindkey '^[' peco-src

zle -N history-beginning-search-backward-end history-search-end
bindkey '^N'   history-beginning-search-forward-end

zle -N history-beginning-search-forward-end history-search-end
bindkey '^P'   history-beginning-search-backward-end

bindkey '^O^B' zaw-git-recent-branches
bindkey '^O^R' zaw-git-branches
bindkey '^R'   zaw-history
bindkey '^T'   zaw-cdr

# {{{1 Tools
# {{{2 Git
if [ -d /usr/local/share/git-core/contrib/diff-highlight ] ; then
    path=(/usr/local/share/git-core/contrib/diff-highlight $path)
fi
if (( $+commands[hub] )); then
    eval "$(hub alias -s)"
fi

# {{{2 direnv
if (( $+commands[direnv] )); then
    eval "$(direnv hook zsh)"
fi

# {{{2 asdf
if (( $+commands[asdf] )); then
  . "$(brew --prefix asdf)/libexec/asdf.sh"
fi

# {{{2 travis
[ -f $HOME/.travis/travis.sh ] && source $HOME/.travis/travis.sh

[ -f ~/.zshrc.local ] && source ~/.zshrc.local
