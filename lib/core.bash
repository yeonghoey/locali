#!/usr/bin/env bash

set -euo pipefail

LOCAL_ROOT="$HOME/.local"
LOCAL_BIN="${LOCAL_ROOT}/bin"
LOCAL_REPOS="${LOCAL_ROOT}/repos"

require-dir() {
  mkdir -p "$1"
}

require-dir "${LOCAL_ROOT}"
require-dir "${LOCAL_BIN}"
require-dir "${LOCAL_REPOS}"

LOCALRC="$HOME/.localrc"
if [[ ! -e "$LOCALRC" ]]; then
  touch "$LOCALRC"
fi

append-localrc() {
  local line="$1"
  # Append only there is no exact matching line.
  if ! grep --quiet --fixed-strings "$line" "$LOCALRC"; then
    echo "$line" >> "$LOCALRC"
  fi
}
