#!/usr/bin/env bash
#
# Helper functiosn related to commands

################################################################################
# Arguments:
#   $1: A name of function
# Returns:
#   0 if exists, 1 otherwise
################################################################################
exists_function() {
  declare -f "$1" > /dev/null
}

################################################################################
# Arguments:
#   $1: A name of command
# Returns:
#   0 if exists, 1 otherwise
################################################################################
exists_command() {
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
