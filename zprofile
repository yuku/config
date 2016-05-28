# Load all functions in zfunctions directory lazily
fpath=(${DOTFILES_ROOT}/zfunctions(N-/) $fpath)
for i in $(ls ${DOTFILES_ROOT}/zfunctions) ; do
    autoload -U $i
done

# vim: filetype=zsh
