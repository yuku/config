# Setup python environemnts for neovim using pyenv
pyenv install -s 2.7.13
pyenv virtualenv 2.7.13 neovim2
export PYENV_VERSION=neovim2
pip install neovim

pyenv install -s 3.6.1
pyenv virtualenv 3.6.1 neovim3
export PYENV_VERSION=neovim3
pip install neovim

unset PYENV_VERSION

WITHOUT_COLORSCHEME=1 nvim -c 'PlugInstall | qall'
WITHOUT_COLORSCHEME=1 vim -c 'PlugInstall | qall'
