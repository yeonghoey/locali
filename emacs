#!/usr/bin/env bash
{
set -euo pipefail
eval "$(curl -sL locali.sh/init.bash)"

# TODO: Support Ubuntu
curl -sL locali.sh/brew | bash
brew tap 'd12frosted/emacs-plus'
brew install 'emacs-plus'
}
