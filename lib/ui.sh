#!/usr/bin/env bash
#
# User interactions


################################################################################
# Prints a question and read 1 character.
# Arguments:
#   $1: A question. appended '(y/n)'
################################################################################
prompt() {
  echo "$1 (y/n) "
  read -r -n 1
  echo
}

################################################################################
# Returns 0 if previous prompt was 'Yy'
################################################################################
answer_is_yes() {
  if [[ "$REPLY" =~ ^[Yy]$ ]]; then
    return 0
  else
    return 1
  fi
}
