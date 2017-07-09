#!/usr/bin/env bash

git_repo() {
  git -C "${LOCAL_REPO}" clone "$1" || true
}

add_path() {
  if [[ ":${PATH}:" != *":$1:"* ]]; then
    PATH="$1:${PATH}"
  fi 
}

{
  export LOCAL_REPO="${HOME}/.local/repo"
  export LOCAL_BIN="${HOME}/.local/bin"
  add_path "$LOCAL_BIN"
}

(
  mkdir -p "${LOCAL_BIN}"
  mkdir -p "${LOCAL_REPO}"
)
