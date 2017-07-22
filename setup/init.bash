#!/usr/bin/env bash

export LOCAL_ROOT="${HOME}/.local"
mkdir -p "${LOCAL_ROOT}"

export LOCAL_REPO="${LOCALROOT}/repo"
mkdir -p "${LOCAL_REPO}"

export LOCAL_BIN="${LOCALROOT}/bin"
mkdir -p "${LOCAL_BIN}"

export LOCALRC="${HOME}/.localrc"
touch "${LOCALRC}"


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

addpath() {
  if [[ ":${PATH}:" != *":$1:"* ]]; then
    PATH="$1:${PATH}"
  fi
}

gitrepo() {
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

symlink() {
  local relpath="$1"
  local target="$2"
  # -i, interactive
  # -s, symlink
  ln -is "${LOCAL_REPO}/${relpath}" "${target}"
}


# Add to PATH for current use
export PATH="${LOCAL_BIN}:${PATH}"

# Add to PATH in ~/.localrc for future use
localrc 'localish' << EOF
export PATH="${LOCAL_BIN}:\${PATH}"
EOF
