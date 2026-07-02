# Start configuration added by Zim Framework install {{{
#
# User configuration sourced by interactive shells
#

# -----------------
# Zsh configuration
# -----------------

#
# History
#

# Remove older command from the history if a duplicate is to be added.
setopt HIST_IGNORE_ALL_DUPS

#
# Input/output
#

# Set editor default keymap to emacs (`-e`) or vi (`-v`)
bindkey -e

# Prompt for spelling correction of commands.
#setopt CORRECT

# Customize spelling correction prompt.
#SPROMPT='zsh: correct %F{red}%R%f to %F{green}%r%f [nyae]? '

# Remove path separator from WORDCHARS.
WORDCHARS=${WORDCHARS//[\/]}

# --------------------
# Module configuration
# --------------------

#
# git
#

# Set a custom prefix for the generated aliases. The default prefix is 'G'.
#zstyle ':zim:git' aliases-prefix 'g'

#
# input
#

# Append `../` to your input for each `.` you type after an initial `..`
#zstyle ':zim:input' double-dot-expand yes

#
# termtitle
#

# Set a custom terminal title format using prompt expansion escape sequences.
# See http://zsh.sourceforge.net/Doc/Release/Prompt-Expansion.html#Simple-Prompt-Escapes
# If none is provided, the default '%n@%m: %~' is used.
#zstyle ':zim:termtitle' format '%1~'

#
# zsh-autosuggestions
#

# Disable automatic widget re-binding on each precmd. This can be set when
# zsh-users/zsh-autosuggestions is the last module in your ~/.zimrc.
ZSH_AUTOSUGGEST_MANUAL_REBIND=1

# Customize the style that the suggestions are shown with.
# See https://github.com/zsh-users/zsh-autosuggestions/blob/master/README.md#suggestion-highlight-style
#ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=242'

#
# zsh-syntax-highlighting
#

# Set what highlighters will be used.
# See https://github.com/zsh-users/zsh-syntax-highlighting/blob/master/docs/highlighters.md
ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets)

# Customize the main highlighter styles.
# See https://github.com/zsh-users/zsh-syntax-highlighting/blob/master/docs/highlighters/main.md#how-to-tweak-it
#typeset -A ZSH_HIGHLIGHT_STYLES
#ZSH_HIGHLIGHT_STYLES[comment]='fg=242'

# ------------------
# Initialize modules
# ------------------

ZIM_HOME=${ZDOTDIR:-${HOME}}/.zim
# Download zimfw plugin manager if missing.
if [[ ! -e ${ZIM_HOME}/zimfw.zsh ]]; then
  if (( ${+commands[curl]} )); then
    curl -fsSL --create-dirs -o ${ZIM_HOME}/zimfw.zsh \
        https://github.com/zimfw/zimfw/releases/latest/download/zimfw.zsh
  else
    mkdir -p ${ZIM_HOME} && wget -nv -O ${ZIM_HOME}/zimfw.zsh \
        https://github.com/zimfw/zimfw/releases/latest/download/zimfw.zsh
  fi
fi
# Install missing modules, and update ${ZIM_HOME}/init.zsh if missing or outdated.
if [[ ! ${ZIM_HOME}/init.zsh -nt ${ZIM_CONFIG_FILE:-${ZDOTDIR:-${HOME}}/.zimrc} ]]; then
  source ${ZIM_HOME}/zimfw.zsh init
fi
# Initialize modules.
source ${ZIM_HOME}/init.zsh
# }}} End configuration added by Zim Framework install


# Alias {{{
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
alias mux="tmuxinator"

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
# }}}

# SSH agent {{{
# http://qiita.com/sonots/items/2d7950a68da0a02ba7e4
agent="$HOME/.ssh/agent"
if [ -S "$SSH_AUTH_SOCK" ]; then
  case $SSH_AUTH_SOCK in
  /tmp/*/agent.[0-9]*)
    ln -snf "$SSH_AUTH_SOCK" $agent && export SSH_AUTH_SOCK=$agent
  esac
elif [ -S $agent ]; then
  export SSH_AUTH_SOCK=$agent
fi

# Override 'pbcopy' when connected via SSH to forward clipboard data
# from the remote server back to the local host machine.
# 
# Standard 'pbcopy' writes to the remote machine's clipboard. Instead, 
# this function reads stdin, encodes it to Base64 (stripping newlines), 
# and sends it using the OSC 52 ANSI escape sequence. Modern terminal 
# emulators (like Ghostty, iTerm2, Alacritty) intercept this sequence 
# and securely place the payload into your local system clipboard.
if [ -n "$SSH_CONNECTION" ]; then
    function pbcopy() {
        local b64="$(cat | base64 | tr -d '\n\r')"
        printf "\e]52;c;%s\a" "$b64"
    }
fi

# Keybinding {{{
stty -ixon # Disable Ctrl-S and Ctrl-Q flow control to allow using them for other purposes.
bindkey -e # emacs like keybinding. Must call before following bindkey settings.

zle -N git_fetch
bindkey '^G^F' git_fetch

zle -N git_pull_current_branch
bindkey '^G^P' git_pull_current_branch

zle -N git_status
bindkey '^G^S' git_status

zle -N git_checkout_pull_request
bindkey '^O^E' git_checkout_pull_request

zle -N ghq_src
bindkey '^]' ghq_src

zle -N zoxide_interactive
bindkey '^T' zoxide_interactive

zle -N history-beginning-search-forward-end history-search-end
bindkey '^N'   history-beginning-search-forward-end

zle -N history-beginning-search-forward-end history-search-end
bindkey '^P'   history-beginning-search-forward-end

zle -N fzf_git_recent_branches
bindkey '^O^B' fzf_git_recent_branches

# }}}

eval "$(zoxide init zsh)"
eval "$(starship init zsh)"

[ -f ~/.zshrc.local ] && source ~/.zshrc.local
