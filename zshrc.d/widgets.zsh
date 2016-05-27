autoload history-search-end
zle -N git_fetch
zle -N git_pull_current_branch_from_origin
zle -N git_status
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
zle -N self-insert url-quote-magic # Automatically escape URL string
