# Load all functions in zfunctions directory lazily
fpath=(${DOTFILES_ROOT}/zfunctions(N-/) $fpath)
for i in $(ls ${DOTFILES_ROOT}/zfunctions) ; do
    autoload -U $i
done

for file in ${DOTFILES_ROOT}/zprofile.d/*; do
    source "$file"
done

# vim: filetype=zsh
