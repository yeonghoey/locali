# '|| true' not to cause to abort when skipping install
pyenv install 2.7.15 || true
pyenv install 3.7.0  || true
pyenv global 3.7.0
