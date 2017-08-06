#!/usr/bin/env bash
#
# Define file manipulating helper functions

################################################################################
# Replaces actual home pathes with ${HOME}
#
# Arguments:
#   $1: A string contains pathes
# Prints:
#   A string containing '${HOME}' rather tan actual home pathes
# Example:
#   '/User/yeonghoey/.localrc' -> '${HOME}/.localrc'
################################################################################
home_relpathed() {
  # Replace '/user/<username>/*' with '${HOME}/.local/*'
  local content="$1"
  local relpath="${LOCAL_ROOT#"${HOME}"}"
  local sedexp="s:${LOCAL_ROOT}:\${HOME}${relpath}:g"
  echo "$content" | sed "${sedexp}"
}

################################################################################
# Writes a content to a file
#
# Uses:
#   lib/ui.sh: info
# Arguments:
#   $1          : A file path
#   $2(optional): A content to be existing in the file, use stdin if not passed.
################################################################################
require_file() {
  if [[ "$#" == 1 ]]; then
    local path="$1"
    local content="$(cat -)"
  else
    local path="$1"
    local content="$2"
  fi
  info "Write to '${path}'"
  echo "$content" | tee "${path}"
}

################################################################################
# Appends a content to a file if not existing.
#
# Uses:
#   lib/ui.sh: info
# Arguments:
#   $1          : A file path
#   $2(optional): A content to be existing in the file, use stdin if not passed.
################################################################################
require_content() {
  if [[ "$#" == 1 ]]; then
    local path="$1"
    local content="$(cat -)"
  else
    local path="$1"
    local content="$2"
  fi

  if ! grep -qF "${content}" "${path}"; then
    info "Append to '${path}'"
    echo -e "${content}\n" | tee -a "${path}"
  fi
}

################################################################################
# Appends a content from stdin to localrc if not existing.
#
# Globals:
#   LOCALRC
# Arguments:
#   $1        : A label for the content
#   /dev/stdin: A content to be appended to "${HOME}/.localrc"
################################################################################
localrc() {
  local label="$1"
  local content="$(home_relpathed "$(cat -)")"

  # Put label
  content="$(echo -e "# ${label}\n${content}")"

  require_content "${LOCALRC}" "${content}"
}

################################################################################
# Prints the absolute path.
#
# Arguments:
#   $1: A path
################################################################################
abspath() {
  echo "$(cd "$(dirname "$1")"; pwd)/$(basename "$1")"
}

################################################################################
# Place a number extension with enusuring the path doesn't exist
#
# Arguments:
#   $1: A path
# Prints:
#   numbered 'file.bk' -> 'file.bk' or 'file.bk.1', 'file.bk.2' etc.
################################################################################
numbered() {
  local path="$1"
  if [[ ! -e "$path" ]]; then
    echo "$path"
    return 0
  fi

  local n=0
  while true; do
    if [[ ! -e "$path.$n" ]]; then
      echo "$path.$n"
      return 0
    fi
    n="$((n + 1))"
  done
}

################################################################################
# Extract a file
#
# Arguments:
#   $1: A path
#   $2: A target directory
################################################################################
extract () {
  local path="$1"
  local target_dir="$2"

  info "Extract '"$(basename "$path")"' into '$target_dir'"
  if [[ -f "$path" ]]; then
    case "$path" in
      *.tar.bz2) tar -C "$target_dir" -jxvf "$path"          ;;
      *.tar.gz)  tar -C "$target_dir" -zxvf "$path"          ;;
      *.tar)     tar -C "$target_dir" -xvf "$path"           ;;
      *.zip)     unzip -d "$target_dir" "$path"              ;;
      *.ZIP)     unzip -d "$target_dir" "$path"              ;;
      *)         info "Unabled to extract '$path'"; return 1 ;;
    esac
  else
    info "File '$path' doesn't exist."
    return 1
  fi
}
