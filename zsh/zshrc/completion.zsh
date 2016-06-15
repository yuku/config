fpath=($DOTFILES_ROOT/modules/zsh-completions/src $fpath)
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
