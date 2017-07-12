#!/usr/bin/env bash
{
set -euo pipefail
eval "$(curl -sL locali.sh/init.bash)"

include 'core'
require 'emacs'

gitrepo 'https://github.com/syl20bnr/spacemacs'
symlink 'spacemacs' "${HOME}/.emacs.d"
}
