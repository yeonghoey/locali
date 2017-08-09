repo_git 'https://github.com/pyenv/pyenv.git'
repo_git 'https://github.com/pyenv/pyenv-virtualenv.git' 'pyenv/plugins/pyenv-virtualenv'

localrc 'pyenv' << EOF
export PYENV_ROOT="${LOCAL_REPO}/pyenv"
export PATH="\${PYENV_ROOT}/bin:\${PATH}"
eval "\$(pyenv init -)"
eval "\$(pyenv virtualenv-init -)"
EOF

pyenv install 2.7.13
pyenv install 3.6.2
pyenv virtualenv 2.7.13 venv
pyenv virtualenv 3.6.2  venv3
pyenv global venv venv3
