# install 'tpm' | dotfiles

repo_git 'https://github.com/tmux-plugins/tpm'
repo_sym 'tpm' "$HOME/.tmux/plugins/tpm"
repo_run 'tpm/bin/install_plugins'
