# ~/.gitconfig.local

# ------------------------------------------------------------------------------

readonly GITCONFIG_LOCAL="${HOME}/.gitconfig.local"

if [[ -e "${GITCONFIG_LOCAL}" ]]; then
  info "'${GITCONFIG_LOCAL}' already exists. skipped."
  cat "${GITCONFIG_LOCAL}"
else
  prompt 'Git user name'
  USER_NAME="$(answer)"

  prompt 'Git user email'
  USER_EMAIL="$(answer)"

  require_file "${GITCONFIG_LOCAL}" <<EOF
[user]
  name = ${USER_NAME}
  email = ${USER_EMAIL}
EOF
fi
