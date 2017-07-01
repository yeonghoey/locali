#!/usr/bin/env bash

set -euo pipefail

clone-or-pull() {
  local repo="$1"
  local directory="$2"
  if [[ -d "$directory" ]]; then
    git -C "$directory" pull
  else
    git clone "$repo" "$directory"
  fi
}
