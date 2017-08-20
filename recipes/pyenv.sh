repo_git 'https://github.com/pyenv/pyenv.git'
repo_git 'https://github.com/pyenv/pyenv-virtualenv.git' 'pyenv/plugins/pyenv-virtualenv'

localrc 'pyenv' << EOF

export PYENV_ROOT="${LOCAL_REPO}/pyenv"
export PATH="\${PYENV_ROOT}/bin:\${PATH}"
eval "\$(pyenv init -)"
eval "\$(pyenv virtualenv-init -)"

EOF
