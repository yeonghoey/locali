#!/usr/bin/env bash
#
# Define helper functions related to LOCAL_REPO

################################################################################
# Clones a git repostiory or pulls it if existing
#
# Globals:
#   LOCAL_REPO
# Arguments:
#   $1          : A URL for the git remote repository
#   $2(optional): A path prefix under LOCAL_REPO
################################################################################
repo_git() {
  local url="$1"
  local name="$(basename ${url} .git)"
  local prefix="${2:-}"
  local target="${LOCAL_REPO}/${prefix}${name}"

  if [[ -d "${target}" ]]; then
    git -C "${target}" pull
  else
    # Ensure the parent directories exist
    mkdir -p "${target}"
    git clone "${url}" "${target}"
  fi
}

################################################################################
# Symlinks files under LOCAL_REPO
#
# Globals:
#   LOCAL_REPO
#   LOCAL_BIN
# Arguments:
#   $1          : A relative path to LOCAL_REPO
#   $2(optional): A path for symlink. Make a symlink under LOCAL_BIN by default
################################################################################
repo_sym() {
  local src="${LOCAL_REPO}/$1"
  local dst="${LOCAL_BIN}/"

  if [[ "$#" == 2 ]]; then
    dst="$2"
    mkdir -p "$(dirname "$dst")"
  fi

  # -i, interactive
  # -s, symlink
  ln -is "$src" "$dst"
}

################################################################################
# Clone a git repostiory or pull it if existing
#
# Globals:
#   LOCAL_REPO
#   LOCAL_BIN
# Arguments:
#   $1              : A relative path to LOCAL_REPO for a command
#   ${@:2}(optional): Arguments for the command
################################################################################
repo-run() {
  local run="${LOCAL_REPO}/$1"
  "$run" "${@:2}"
}
