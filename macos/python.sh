#!/usr/bin/env bash

set -euo pipefail

WORKDIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SHUP="$(dirname "$WORKDIR")"

source "${SHUP}/lib/git.sh"
source "${SHUP}/lib/localrc.sh"

clone-or-pull 'https://github.com/pyenv/pyenv.git' "$HOME/.pyenv"

append-localrc 'export PYENV_ROOT="$HOME/.pyenv"'
append-localrc 'export PATH="$PYENV_ROOT/bin:$PATH"'
