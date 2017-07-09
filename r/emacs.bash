#!/usr/bin/env bash

set -euo pipefail

run_emacs() {
  # TODO: Support Ubuntu
  local brew="${HOME}/.local/bin/brew"
  $brew tap 'd12frosted/emacs-plus'
  $brew install 'emacs-plus'
}

run_emacs
