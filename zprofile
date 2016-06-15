# Load all functions in zfunctions directory lazily
fpath=(${DOTFILES_ROOT}/zsh/functions $fpath)
for i in $(ls ${DOTFILES_ROOT}/zsh/functions) ; do
    autoload -U $i
done

for file in ${DOTFILES_ROOT}/zsh/zprofile/*; do
    source "$file"
done

# vim: filetype=zsh
