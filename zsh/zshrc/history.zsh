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
