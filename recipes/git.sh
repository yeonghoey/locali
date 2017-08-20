# Install git plugins and config '.gitconfig.local'

# ------------------------------------------------------------------------------


require_ubuntu && {
  # git-flow
  sudo apt-get update
  sudo apt-get install -y git-flow

  # git-lfs
  curl -s 'https://packagecloud.io/install/repositories/github/git-lfs/script.deb.sh' | sudo bash
  sudo apt-get install -y git-lfs
  git lfs install
}

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
