autoload -Uz chpwd_recent_dirs cdr add-zsh-hook # Activate cdr command for zaw-cdr

source $DOTFILES_ROOT/modules/zaw/zaw.zsh
source $DOTFILES_ROOT/modules/zaw/sources/git-recent-branches.zsh
source $DOTFILES_ROOT/modules/zaw/sources/git-branches.zsh

add-zsh-hook chpwd chpwd_recent_dirs

zstyle ':chpwd:*' recent-dirs-default yes
zstyle ':chpwd:*' recent-dirs-max 5000

bindkey '^O^B' zaw-git-recent-branches
bindkey '^O^R' zaw-git-branches
bindkey '^R'   zaw-history
bindkey '^T'   zaw-cdr
