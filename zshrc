# Enable zsh version conditional branch.
autoload -Uz is-at-least

for file in ${DOTFILES_ROOT}/zsh/zshrc/*; do
    source "$file"
done

# syntax-highlighting.zsh must be sourced at the end of the .zshrc
source ${DOTFILES_ROOT}/modules/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

[ -f ~/.zshrc.local ] && source ~/.zshrc.local
