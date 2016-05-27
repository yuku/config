export DOTFILES_ROOT=$(ghq root)/github.com/yuku-t/dotfiles

for file in ${DOTFILES_ROOT}/zshenv.d/*; do
    source "$file"
done
