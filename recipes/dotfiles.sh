stow_localish "dotfiles" "${HOME}"

# init_gitconfig_local() {
#   local target="${HOME}/.gitconfig.local"

#   if [[ -e "$target" ]]; then
#     info "'$target' already exists. skipped."
#     cat "$target"
#     return 0
#   fi

#   prompt 'Git user name'
#   local NAME="$(answer)"
#   prompt 'Git user email'
#   local EMAIL="$(answer)"

#   require_file "$target" <<EOF
# [user]
#   name = ${NAME}
#   email = ${EMAIL}
# EOF
# }

# init_tpm() {
#   repo_git 'https://github.com/tmux-plugins/tpm'
#   repo_sym 'tpm' "$HOME/.tmux/plugins/tpm"
# }

# stow_dotfiles        || return 1
# init_gitconfig_local || return 1
# init_tpm             || return 1
