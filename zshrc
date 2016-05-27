# Enable zsh version conditional branch.
autoload -Uz is-at-least

# Load all functions in zfunctions directory lazily
fpath=(${DOTFILES_ROOT}/zfunctions(N-/) $fpath)
for i in $(ls ${DOTFILES_ROOT}/zfunctions) ; do
    autoload -U $i
done

for file in ${DOTFILES_ROOT}/zshrc.d/*; do
    source "$file"
done

# syntax-highlighting.zsh must be sourced at the end of the .zshrc
source ${DOTFILES_ROOT}/modules/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

[ -f ~/.zshrc.local ] && source ~/.zshrc.local
