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
################################################################################
extract () {
  if [[ -f "$1" ]]; then
    case "$1" in
      *.tar.bz2) tar -jxvf $1                        ;;
      *.tar.gz)  tar -zxvf $1                        ;;
      *.bz2)     bunzip2 $1                          ;;
      *.dmg)     hdiutil mount $1                    ;;
      *.gz)      gunzip $1                           ;;
      *.tar)     tar -xvf $1                         ;;
      *.tbz2)    tar -jxvf $1                        ;;
      *.tgz)     tar -zxvf $1                        ;;
      *.zip)     unzip $1                            ;;
      *.ZIP)     unzip $1                            ;;
      *.pax)     cat $1 | pax -r                     ;;
      *.pax.Z)   uncompress $1 --stdout | pax -r     ;;
      *.rar)     unrar x $1                          ;;
      *.Z)       uncompress $1                       ;;
      *)         info "'$1' cannot be extracted/mounted via extract()" ;;
    esac
  else
    echo "'$1' is not a valid file"
  fi
}
