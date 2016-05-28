bindkey -e # emacs like keybinding. Must call before following bindkey settings.

bindkey '^G^F' git_fetch
bindkey '^G^P' git_pull_current_branch_from_origin
bindkey '^G^S' git_status
bindkey '^N'   history-beginning-search-forward-end
bindkey '^P'   history-beginning-search-backward-end

zle -N peco-src
bindkey '^[' peco-src
