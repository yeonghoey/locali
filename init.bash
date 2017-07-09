#!/usr/bin/env bash
{
git_repo() {
  git -C "${LOCAL_REPO}" clone "$1" 2> /dev/null || true
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
