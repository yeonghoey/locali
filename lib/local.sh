#!/usr/bin/env bash
#
# Declare LOCAL variables and ensure they are existing

declare -rx LOCAL_ROOT="${HOME}/.local"
declare -rx LOCAL_REPO="${LOCAL_ROOT}/repo"
declare -rx LOCAL_BIN="${LOCAL_ROOT}/bin"
declare -rx LOCALRC="${HOME}/.localrc"

mkdir -p "${LOCAL_ROOT}"
mkdir -p "${LOCAL_REPO}"
mkdir -p "${LOCAL_BIN}"
touch "${LOCALRC}"

# Add LOCAL_BIN to PATH for current shell
export PATH="${LOCAL_BIN}:${PATH}"
