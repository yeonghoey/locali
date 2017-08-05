#!/usr/bin/env bash
#
# User interactions


################################################################################
# Prints a notification message in a consistent format.
################################################################################
noti() {
  echo "[*] $1"
}

################################################################################
# Prints a progress infomation message in a consistent format.
################################################################################
info() {
  echo "  - $1"
}

################################################################################
# Prints a question and read an answer.
# Arguments:
#   $1: A question.
################################################################################
prompt() {
  printf "  ? $1: "
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
  printf "  ? $1 (y/n) "
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
