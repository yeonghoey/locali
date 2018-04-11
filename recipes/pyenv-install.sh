# install 2.7.13, 3.6.2, venv and venv3

# '|| true' not to cause to abort when skipping install
pyenv install 2.7.14 || true
pyenv install 3.6.5  || true
pyenv virtualenv 3.6.5  venv || true
pyenv global venv
