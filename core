#!/usr/bin/env bash
{
# Declare base variables
export LOCALRC="${HOME}/.localrc"
touch "${LOCALRC}"

export LOCAL_ROOT="${HOME}/.local"
mkdir -p "${LOCAL_ROOT}"

export LOCAL_BIN="${LOCAL_ROOT}/bin"
mkdir -p "${LOCAL_BIN}"

export LOCAL_REPO="${LOCAL_ROOT}/repo"
mkdir -p "${LOCAL_REPO}"


# Helper functions
addpath() {
  if [[ ":${PATH}:" != *":$1:"* ]]; then
    PATH="$1:${PATH}"
  fi
}

homepath() {
  local path="$1"
  local relpath="${path#"${HOME}"}"
  echo "\${HOME}${relpath}"
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

localrc() {
  local content="$(cat -)"
  if ! grep -q "${content}" "${LOCALRC}"; then
    echo "$content" >> "${LOCALRC}"
  fi
}


# Initialize
addpath "${LOCAL_BIN}"

localrc << EOF
export PATH="$(homepath ${LOCAL_BIN}):\${PATH}"
EOF
}
