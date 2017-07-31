#!/usr/bin/env bash

# ------------------------------------------------------------------------------

# ------------------------------------------------------------------------------

localrc-add() {
  local label="$1"
  local content="$(relpath-home "$(cat -)")"

  # Put label
  content="$(echo -e "# ${label}\n${content}")"

  # Append content only when the content is not literally matched
  if ! grep -qF "${content}" "${LOCALRC}"; then
    # Put a blank line
    echo -e "\n${content}" | tee -a "${LOCALRC}"
  fi
}

relpath-home() {
  # Replace '/user/<username>/.local/*' with '${HOME}/.local/*'
  local content="$1"
  local relpath="${LOCAL_ROOT#"${HOME}"}"
  local sedexp="s:${LOCAL_ROOT}:\${HOME}${relpath}:g"
  echo "$content" | sed "${sedexp}"
}

command-exists() {
  # SEE: https://stackoverflow.com/questions/592620/check-if-a-program-exists-from-a-bash-script
  command -v "$1" >/dev/null 2>&1
}

command-path() {
  command -v "$1"
}

macos() {
  [[ "$(uname -s)" == "Darwin" ]]
}

ubuntu() {
  [[ "$(uname -s)" == "Linux" ]] && [[ -e "/etc/lsb-release" ]]
}

exists_function() {
  declare -f "$1" > /dev/null
}

prompt() {
  echo "$1 (y/n) "
  read -r -n 1
  echo
}

answer_is_yes() {
  if [[ "$REPLY" =~ ^[Yy]$ ]]; then
    return 0
  else
    return 1
  fi
}

# Add to PATH for current use
export PATH="${LOCAL_BIN}:${PATH}"

# Add to PATH in ~/.localrc for future use
localrc-add 'localish' << EOF
export PATH="${LOCAL_BIN}:\${PATH}"
EOF
