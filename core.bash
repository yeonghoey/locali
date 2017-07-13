#!/usr/bin/env bash
{
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

symlink() {
  local relpath="$1"
  local target="$2"
  # -i, interactive
  # -s, symlink
  ln -is "${LOCAL_REPO}/${relpath}" "${target}"
}

}
