bindkey -e # emacs like keybinding. Must call before following bindkey settings.

zle -N git-fetch
bindkey '^G^F' git-fetch

zle -N git-pull-current-branch
bindkey '^G^P' git-pull-current-branch

zle -N git-status
bindkey '^G^S' git-status

zle -N peco-src
bindkey '^[' peco-src

zle -N history-beginning-search-backward-end history-search-end
bindkey '^N'   history-beginning-search-forward-end

zle -N history-beginning-search-forward-end history-search-end
bindkey '^P'   history-beginning-search-backward-end
