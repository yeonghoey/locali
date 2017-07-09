#!/usr/bin/env bash
{
git_repo() {
  local url="$1"
  local name="$(basename ${url} .git)"
  local target="${LOCAL_REPO}/${name}"
  if [[ -e "${target_dir}" ]]; then
    git -C "${target}" pull
  else
    git clone "${url}" ${target}"
  fi
}

add_path() {
  if [[ ":${PATH}:" != *":$1:"* ]]; then
    PATH="$1:${PATH}"
  fi 
}

export LOCAL_REPO="${HOME}/.local/repo"
mkdir -p "${LOCAL_REPO}"

export LOCAL_BIN="${HOME}/.local/bin"
mkdir -p "${LOCAL_BIN}"

add_path "$LOCAL_BIN"
}
