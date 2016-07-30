if (( $+commands[pyenv] )); then
    # Compile dynamic Python library for YouCompleteMe
    export PYTHON_CONFIGURE_OPTS="--enable-framework"
    eval "$(pyenv init -)"
fi
