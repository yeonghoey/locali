#!/usr/bin/env bash
{
# Declare environment variables
export LOCAL_ROOT="${HOME}/.local"
export LOCAL_REPO="${LOCAL_ROOT}/repo"
export LOCAL_BIN="${LOCAL_ROOT}/bin"
export LOCALRC="${HOME}/.localrc"

mkdir -p "${LOCAL_ROOT}"
mkdir -p "${LOCAL_REPO}"
mkdir -p "${LOCAL_BIN}"
touch "${LOCALRC}"

include() {
  if [[ "${LOCALISH:-}" ]]; then
    source "include/$1.bash"
  else
    eval "$(curl -sL locali.sh/include/$1.bash)"
  fi
}

require() {
  if [[ "${LOCALISH:-}" ]]; then
    "./r/$1"
  else
    bash -c "$(curl -sL locali.sh/r/$1)"
  fi
}

localrc() {
  local label="$1"
  local content="$(cat -)"

  # Replace '/user/<username>/.local/*' with '${HOME}/.local/*'
  local relpath="${LOCAL_ROOT#"${HOME}"}"
  local sedexp="s:${LOCAL_ROOT}:\${HOME}${relpath}:g"
  content="$(echo $content | sed "${sedexp}")"

  # Put label
  content="$(echo -e "# ${label}\n${content}")"

  # Append content only not literally matched
  set -x
  if ! grep -qF "${content}" "${LOCALRC}"; then
    # Put a blank line
    echo -e "\n${content}" >> "${LOCALRC}"
  fi
}

# Add to PATH for current use
export PATH="${LOCAL_BIN}:${PATH}"

# Add to PATH in ~/.localrc for future use
localrc 'localish' << EOF
export PATH="${LOCAL_BIN}:\${PATH}"
EOF

localrc 'localish' << EOF
testing
EOF

}
