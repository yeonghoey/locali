#!/usr/bin/env bash

export LOCAL_ROOT="${HOME}/.local"
export LOCAL_REPO="${LOCAL_ROOT}/repo"
export LOCAL_BIN="${LOCAL_ROOT}/bin"
export LOCAL_RC="${HOME}/.localrc"

mkdir -p "${LOCAL_ROOT}"
mkdir -p "${LOCAL_REPO}"
mkdir -p "${LOCAL_BIN}"
touch "${LOCAL_RC}"

local-rc() {
  local label="$1"
  local content="$(cat -)"

  # Replace '/user/<username>/.local/*' with '${HOME}/.local/*'
  local relpath="${LOCAL_ROOT#"${HOME}"}"
  local sedexp="s:${LOCAL_ROOT}:\${HOME}${relpath}:g"
  content="$(echo $content | sed "${sedexp}")"

  # Put label
  content="$(echo -e "# ${label}\n${content}")"

  # Append content only when the content is not literally matched
  if ! grep -qF "${content}" "${LOCAL_RC}"; then
    # Put a blank line
    echo -e "\n${content}" >> "${LOCAL_RC}"
  fi
}

git-repo() {
  local url="$1"
  local name="$(basename ${url} .git)"
  if [[ "$#" == 1 ]]; then
    local target="${LOCAL_REPO}/${name}"
  elif [[ "$#" == 2 ]]; then
    local prefix="$2"
    local target="${LOCAL_REPO}/${prefix}/${name}"
  fi
  if [[ -d "${target}" ]]; then
    git -C "${target}" pull
  else
    # Ensure the parent directories exist
    mkdir -p "${target}"
    git clone "${url}" "${target}"
  fi
}

bin-link() {
  local relpath="$1"
  local target="$2"
  # -i, interactive
  # -s, symlink
  ln -is "${LOCAL_REPO}/${relpath}" "${LOCAL_BIN}/${target}"
}

# Add to PATH for current use
export PATH="${LOCAL_BIN}:${PATH}"

# Add to PATH in ~/.localrc for future use
local-rc 'localish' << EOF
export PATH="${LOCAL_BIN}:\${PATH}"
EOF
