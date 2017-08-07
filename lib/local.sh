#!/usr/bin/env bash
#
# Declare LOCAL variables and ensure they are existing

declare -rx LOCAL_ROOT="${HOME}/.local"
declare -rx LOCAL_REPO="${LOCAL_ROOT}/repo"
declare -rx LOCAL_BIN="${LOCAL_ROOT}/bin"
declare -rx LOCALRC="${HOME}/.localrc"

mkdir -p "${LOCAL_ROOT}"
mkdir -p "${LOCAL_REPO}"
mkdir -p "${LOCAL_BIN}"
touch "${LOCALRC}"

# Add LOCAL_BIN to PATH for current shell
export PATH="${LOCAL_BIN}:${PATH}"

################################################################################
# Appends a content from stdin to localrc if not existing.
#
# Globals:
#   LOCALRC
# Arguments:
#   $1        : A label for the content
#   /dev/stdin: A content to be appended to "${HOME}/.localrc"
################################################################################
localrc() {
  local label="$1"
  local content="$(home_relpathed "$(cat -)")"

  # Put label
  content="$(echo -e "# ${label}\n${content}")"

  require_content "${LOCALRC}" "${content}"
}

################################################################################
# Read commands from stdin and run under LOCALRC
################################################################################
localrc_run() {
  bash --rcfile "${LOCALRC}" -i <(cat -)
}
