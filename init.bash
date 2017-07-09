#!/usr/bin/env bash
{
# Set LOCALISH_DEV to apply developing changes
# before publishing it
if [[ "${LOCALISH_DEV-}" ]]; then
  unset LOCALISH_DEV
  source init.bash
  return 0
fi

git_repo() {
  local url="$1"
  local name="$(basename ${url} .git)"
  if [[ "$#" == 1 ]]; then
    local target="${LOCAL_REPO}/${name}"
  elif [[ "$#" == 2 ]]; then
    local prefix="$2"
    local target="${LOCAL_REPO}/${prefix}/${name}"
  fi
  if [[ -e "${target}" ]]; then
    git -C "${target}" pull
  else
    git clone "${url}" "${target}"
  fi
}

add_path() {
  if [[ ":${PATH}:" != *":$1:"* ]]; then
    PATH="$1:${PATH}"
  fi 
}

export LOCALRC="${HOME}/.localrc"
touch "${LOCALRC}"
localrc() {
  local content="$(cat -)"
  if grep -q "$content" "${LOCALRC}"; then
    echo "$content" >> "${LOCALRC}"
  fi
}

export LOCAL_REPO="${HOME}/.local/repo"
mkdir -p "${LOCAL_REPO}"

export LOCAL_BIN="${HOME}/.local/bin"
mkdir -p "${LOCAL_BIN}"
add_path "${LOCAL_BIN}"
}
