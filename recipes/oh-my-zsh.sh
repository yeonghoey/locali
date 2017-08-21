# install oh-my-zsh and its custom plugins

repo_git 'https://github.com/robbyrussell/oh-my-zsh.git'
repo_git 'https://github.com/zsh-users/zsh-completions' 'oh-my-zsh/custom/plugins/zsh-completions'

localrc 'oh-my-zsh' <<EOF
export ZSH="${LOCAL_REPOS}/oh-my-zsh"
EOF
