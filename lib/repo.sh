#!/usr/bin/env bash
#
# Define LOCAL_REPO helper functions
#
# Depends:
#   lib/local.sh
#   lib/file.sh
#   lib/ui.sh

################################################################################
# Clones a git repostiory or pulls it if existing
#
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
    info "Pull '${target}'"
    indented git -C "${target}" pull
  else
    # Ensure the parent directories exist
    info "Clone '${url}'"
    mkdir -p "${target}"
    indented git clone "${url}" "${target}"
  fi
}

################################################################################
# Symlinks files under LOCAL_REPO
#
# Arguments:
#   $1: A relative path to LOCAL_REPO
################################################################################
repo_bin() {
  local relpath="$1"
  repo_sym "${relpath}" "${LOCAL_BIN}/$(basename "$relpath")"
}

################################################################################
# Create a symlink from under LOCAL_REPO to a path
#
# Arguments:
#   $1: A relative path to LOCAL_REPO
#   $2: A path for symlink. if path is a existing directory, prompts to delete
################################################################################
repo_sym() {
  local src="${LOCAL_REPO}/$1"
  local dst="$2"

  info "Create a symlink from '$src' to '$dst'"

  if [[ "$src" -ef "$(readlink "$dst")" ]]; then
    info "Symlink already exists. skipped."
    return 0
  fi

  if [[ -e "$dst" ]]; then
    prompt "Path '$dst' already exists. Replace it?"
    if answer_is_yes; then
      local dstbk="$(numbered "${dst}.bk")"
      info "Move '$dst' to '$dstbk'"
      mv "$dst" "$dstbk"
    else
      return 1
    fi
  fi
  # -s, symlink
  ln -s "$(abspath $src)" "$(abspath $dst)"
}

################################################################################
# Run a command under LOCAL_REPO
#
# Arguments:
#   $1              : A relative path to LOCAL_REPO for a command
#   ${@:2}(optional): Arguments for the command
################################################################################
repo_run() {
  local run="${LOCAL_REPO}/$1"
  "$run" "${@:2}"
}
