#!/usr/bin/env bash
{
set -euo pipefail
eval "$(curl -sL locali.sh/init)"

include 'core'

macos() {
  require 'brew'
  brew tap 'd12frosted/emacs-plus'
  brew install 'emacs-plus'
}

# TODO: Support Ubuntu
macos
}
