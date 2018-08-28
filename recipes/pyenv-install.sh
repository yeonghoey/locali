# install python versions
# '|| true' not to cause to abort when skipping install
pyenv install 2.7.15 || true
pyenv install 3.6.5  || true
pyenv install 3.7.0  || true
# NOTE: Use 3.6.5 by default until 3.7.0 is stable.
pyenv global 3.6.5
