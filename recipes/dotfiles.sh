stow_dotfiles() {
  stow --dir="${LOCALISH}" --target="${HOME}" 'dotfiles'
}

init_gitconfig_local() {
  local target="${HOME}/.gitconfig.local"

  if [[ -e "$target" ]]; then
    info "'$target' already exists. skipped."
    indented \
      cat "$target"
    return 0
  fi

  prompt 'Git user name'
  local NAME="$(answer)"
  prompt 'Git user email'
  local EMAIL="$(answer)"

  require_file "$target" <<EOF
[user]
  name = ${NAME}
  email = ${EMAIL}
EOF
}

init_tpm() {
  # Init tmux
  repo_git 'https://github.com/tmux-plugins/tpm'
  repo_sym 'tpm' "$HOME/.tmux/plugins/tpm"
  repo_run 'tpm/bindings/install_plugins'
}

stow_dotfiles
init_gitconfig_local
init_tpm
