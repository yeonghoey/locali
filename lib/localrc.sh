#!/usr/bin/env bash

set -euo pipefail

append-localrc() {
  local line="$1"
  # Append only there is no exact matching line.
  if grep --quiet --invert-match --fixed-strings "$line"; then
    echo "$line" >> "$HOME/.localrc"
  fi
}
