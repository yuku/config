export EDITOR=vim
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
