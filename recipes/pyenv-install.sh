# install 2.7.13, 3.6.2, venv and venv3

# '|| true' not to cause to abort when skipping install
pyenv install 2.7.13 || true
pyenv install 3.6.2  || true
pyenv virtualenv 2.7.13 venv  || true
pyenv virtualenv 3.6.2  venv3 || true
pyenv global venv venv3
