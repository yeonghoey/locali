#!/usr/bin/env bash

set -euo pipefail

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
