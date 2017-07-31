stow --dir="${LOCALISH}" --target="${HOME}" 'dotfiles'

repo_git 'https://github.com/tmux-plugins/tpm'
repo_sym 'tpm' "$HOME/.tmux/plugins"
repo_run 'tpm/bindings/install_plugins'
