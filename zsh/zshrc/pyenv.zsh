if (( $+commands[pyenv] )); then
    PYENV_ROOT=~/.pyenv
    export PATH=$PYENV_ROOT/bin:$PATH
    # Compile dynamic Python library for YouCompleteMe
    export PYTHON_CONFIGURE_OPTS="--enable-framework"
    eval "$(pyenv init -)"
    eval "$(pyenv virtualenv-init -)"
fi
