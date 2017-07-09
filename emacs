#!/usr/bin/env bash
{
set -euo pipefail
eval "$(curl -sL locali.sh/init.bash)"

# TODO: Support Ubuntu
brew tap 'd12frosted/emacs-plus'
brew install 'emacs-plus'
}
