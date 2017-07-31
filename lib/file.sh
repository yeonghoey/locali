#!/usr/bin/env bash
#
# Define file manipulating helper functions

################################################################################
# Replaces actual home pathes with ${HOME}
#
# Arguments:
#   $1: A string contains pathes
# Prints:
#   A string containing '${HOME}' rather tan actual home pathes
# Example:
#   '/User/yeonghoey/.localrc' -> '${HOME}/.localrc'
################################################################################
home_relpathed() {
  # Replace '/user/<username>/*' with '${HOME}/.local/*'
  local content="$1"
  local relpath="${LOCAL_ROOT#"${HOME}"}"
  local sedexp="s:${LOCAL_ROOT}:\${HOME}${relpath}:g"
  echo "$content" | sed "${sedexp}"
}

################################################################################
# Appends a content to a file if not existing. '\n' is placed before it.
#
# Arguments:
#   $1: A file path
#   $2: A content to be existing in the file
# Note:
#   Uses 'tee -a' to show the content
################################################################################
require_content() {
  local path="$1"
  local content="$2"
  if ! grep -qF "${content}" "${path}"; then
    echo ">>> Append to '${path}"
    echo -e "\n${content}" | tee -a "${path}"
  fi
}

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
