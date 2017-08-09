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
# Returns:
#   0 if content appended, 1 otherwise.
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
    return 0
  else
    return 1
  fi
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
# Download a file
#
# Arguments:
#   $1: A source URL
#   $2: A target path
################################################################################
download() {
  local url="$1"
  local path="$2"

  mkdir -p "$(dirname "$path")"

  # A ripoff from
  # https://github.com/alrra/dotfiles/blob/master/src/os/setup.sh

  info "Download '$url' into '$path'"
  if command_exists 'wget'; then

    wget -qO "$path" "$url" &> /dev/null
    #     │└─ write output to file
    #     └─ don't show output
    return "$?"

  elif command_exists 'curl'; then

    curl -LsSo "$path" "$url" &> /dev/null
    #     │││└─ write output to file
    #     ││└─ show error messages
    #     │└─ don't show the progress meter
    #     └─ follow redirects
    return "$?"

  else
    info "Unable to use 'wget' or 'curl'."
    return 1
  fi
}

################################################################################
# Extract a file
#
# Arguments:
#   $1: A path
#   $2: A target directory
################################################################################
extract() {
  local path="$1"
  local target_dir="$2"

  mkdir -p "$target_dir"

  info "Extract '$path' into '$target_dir'"
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

################################################################################
# Arguments:
#   $1: A name of command
# Returns:
#   0 if exists, 1 otherwise
################################################################################
command_exists() {
  # SEE: https://stackoverflow.com/questions/592620/check-if-a-program-exists-from-a-bash-script
  command -v "$1" >/dev/null 2>&1
}

################################################################################
# Arguments:
#   $1: A name of command
# Prints:
#   The absolute path to the command
################################################################################
command_path() {
  command -v "$1"
}
