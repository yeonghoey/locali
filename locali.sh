#!/usr/bin/env bash

set -euo pipefail


################################################################################
# Prints a real directory of the path by following symlinks.
#
# Arguments:
#   $1: A path
################################################################################
realdir() {
  if [[ -z "$1" ]]; then
    pwd
  else
    (
      cd "$(dirname "$1")"
      realdir "$(readlink "$(basename "$1")")"
    )
  fi
}

readonly LOCALISH="$(realdir "$0")"

declare -rx LOCAL_ROOT="${HOME}/.local"
declare -rx LOCAL_REPO="${LOCAL_ROOT}/repo"
declare -rx LOCAL_BIN="${LOCAL_ROOT}/bin"
declare -rx LOCALRC="${HOME}/.localrc"

mkdir -p "${LOCAL_ROOT}"
mkdir -p "${LOCAL_REPO}"
mkdir -p "${LOCAL_BIN}"
touch "${LOCALRC}"


# Add LOCAL_BIN to PATH if not existing
if [[ ":${PATH}:" != *":${LOCAL_BIN}:"* ]]; then
  export PATH="${LOCAL_BIN}:${PATH}"
fi


################################################################################
# Appends a content from stdin to localrc if not existing.
#
# Params:
#   $1        : A label for the content
#   /dev/stdin: A content to be appended to "${HOME}/.localrc"
################################################################################
localrc() {

  local label="$1"
  local content=""


  # Read from '/dev/stdin', mostly for Here document
  content="$(cat -)"

  # Normalize home pathes relative to $HOME
  content="${content//$HOME/\$HOME}"

  # Put the label at head
  content="$(echo -e "# ${label}\n${content}")"


  require_content "${LOCALRC}" "${content}"
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

  if ! contains "$(cat "$path")" "$content"; then
    info "Append to '$path'"
    echo -e "\n${content}\n" | tee -a "${path}"
  else
    info "'$LOCALRC' already contains the content. Skipped."
  fi
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
# Params:
#   $1: A file path which requires that its directory exists
################################################################################
require_dir() {
  mkdir -p "$(dirname "$1")"
}


################################################################################
# Tests whether a string contains another
#
# Arguments:
#   $1: A string to be tested
#   $2: A substring
################################################################################
contains() {
  local str="$1"
  local sub="$2"
  [[ "$str" == *"$sub"* ]]
}


################################################################################
# Parse text files formatted like 'requirements.txt'. Exclude '#' lines.
#
# Arguments:
#   $1: A path to requirements file
# Prints:
#   Names of requirements separated whitespaces
# See:
#   https://askubuntu.com/questions/252734/apt-get-mass-install-packages-from-a-file
################################################################################
requirements() {

  local path="$1"

  grep -vE "^\s*#" "${path}"  | tr "\n" " "
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


################################################################################
# Tests whether current OS is macOS
################################################################################
require_macos() {
  [[ "$(uname -s)" == "Darwin" ]]
}


################################################################################
# Tests whether current OS is Ubuntu
################################################################################
require_ubuntu() {
  [[ "$(uname -s)" == "Linux" ]] && [[ -e "/etc/lsb-release" ]]
}


################################################################################
# Clones a git repostiory or pulls it if existing
#
# Arguments:
#   $1          : A URL for the git remote repository
#   $2(optional): A repo name which will be placed under LOCAL_REPO
################################################################################
repo_git() {
  local url="$1"
  local name="${2-$(basename $url .git)}"
  local repo="${LOCAL_REPO}/$name"

  if [[ -d "$repo" ]]; then
    info "Pull '$repo'"
    git -C "$repo" pull
  else
    # Ensure the parent directories exist
    mkdir -p "$repo"

    info "Clone '$url'"
    git clone "$url" "$repo"
  fi
}


################################################################################
# Get a compressed file and extract it as a repo
#
# Arguments:
#   $1: A URL for download via wget
#   $2: A folder name under LOCAL_REPO where the file is extracted in.
################################################################################
repo_zip() {
  local url="$1"
  local file="$(basename $url)"
  local filename="${file%.*}"
  local name="${2-$filename}"
  local repo="${LOCAL_REPO}/$name"
  local download_path="$(mktemp -d)/$file"

  download "$url" "$download_path"
  extract  "$download_path" "$repo"
}


################################################################################
# Get a file and put it into a repo
#
# Arguments:
#   $1: A URL for download via wget
#   $2: A relpath under LOCAL_REPO
################################################################################
repo_get() {
  local url="$1"
  local download_path="${LOCAL_REPO}/$2"
  download "$url" "$download_path"
}


################################################################################
# Symlinks files under LOCAL_REPO
#
# Arguments:
#   $1: A relative path to LOCAL_REPO
################################################################################
repo_bin() {

  local src="${LOCAL_REPO}/$1"
  local dst=""

  # Use the same file name
  dst="${LOCAL_BIN}/$(basename "$src")"


  info "Make '$src' executable."
  chmod +x "$src"

  symlink "$src" "$dst"
}


################################################################################
# Create a symlink from under LOCAL_REPO to a path
#
# Arguments:
#   $1: A relative path to LOCAL_REPO
#   $2: A path for symlink. if path is a existing directory, prompts to replace
################################################################################
repo_sym() {

  local src="${LOCAL_REPO}/$1"
  local dst="$2"

  symlink "$src" "$dst"
}


################################################################################
# Create a symlink
#
# Arguments:
#   $1: A src path
#   $2: A path for symlink. if path is a existing directory, prompts to replace
################################################################################
symlink() {

  local src="$1"
  local dst="$2"
  local dstbk=""


  info "Create a symlink from '${src}' to '${dst}'"


  if [[ "$src" -ef "$(readlink "$dst")" ]]; then
    #           └┤
    #            └ True if both refer to the same device and inode numbers.
    info "Symlink already exists. Skipped."
    return 0
  fi


  if [[ ! -e "${src}" ]]; then
    info "'${src}' does not exist."
    return 1
  fi


  if [[ -e "${dst}" ]]; then

    prompt_yn "Path '${dst}' already exists. Replace it?"
    if answer_is_yes; then

      dstbk="$(numbered "${dst}.bk")"

      info "Move '${dst}' to '${dstbk}'"
      mv "${dst}" "${dstbk}"

    else
      return 1
    fi
  else

    require_dir "${dst}"

  fi


  ln -s "$(abspath "${src}")" "$(abspath "${dst}")"
}


stow_localish() {
  local src="$1"
  local dst="$2"
  stow --verbose --dir="${LOCALISH}" "${src}" --target="${dst}"
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
  info "Run '$run'"
  "$run" "${@:2}"
}


################################################################################
# Prints a notification message in a consistent format.
################################################################################
noti() {
  echo "* $1"
}


################################################################################
# Prints a progress infomation message in a consistent format.
################################################################################
info() {
  echo "- $1"
}


################################################################################
# Prints a question and read an answer.
# Arguments:
#   $1: A question.
################################################################################
prompt() {
  printf "? %s: " "$1"
  read -r
}


################################################################################
# Prints a question and read an answer.
# Prints:
#   The answer of the last prompt.
################################################################################
answer() {
  echo "${REPLY}"
}


################################################################################
# Prints a question and read 1 character.
# Arguments:
#   $1: A question.
################################################################################
prompt_yn() {
  printf "? %s (y/n) " "$1"
  read -r -n 1
  echo
}


################################################################################
# Returns 0 if previous prompt was 'Yy'
################################################################################
answer_is_yes() {
  if [[ "${REPLY}" =~ ^[Yy]$ ]]; then
    return 0
  else
    return 1
  fi
}


################################################################################
# Run command with its stdout and stderr indented
################################################################################
indented() {
  "$@" 2>&1 | sed 's/^/    /'
}


################################################################################
# Require sudo athorization and keep it alive.
################################################################################
use_sudo() {
  sudo -v &> /dev/null

  # Update existing `sudo` time stamp
  # until this script has finished.
  # https://gist.github.com/cowboy/3118588
  while true; do
    sudo -n true
    sleep 60
    kill -0 "$$" || exit
  done &> /dev/null &
}


################################################################################
# Run recipes
# Arguments:
#   Names of recipes in "$LOCALISH/recipes"
################################################################################
run_recipes() {
  for recipe in "$@"; do
    noti "Run: '${recipe}'"
    if (source "${LOCALISH}/recipes/${recipe}.sh"); then
      noti "Done: '${recipe}'"
    else
      noti "Abort: '${recipe}'"
      return 1
    fi
  done
}


# ------------------------------------------------------------------------------


run_recipes "$@"
