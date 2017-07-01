#!/usr/bin/env bash

set -euo pipefail

WORKDIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SHUP="$(dirname "$WORKDIR")"

source "${SHUP}/lib/github.sh"
source "${SHUP}/lib/localrc.sh"

github-fresh 'https://github.com/pyenv/pyenv.git' "$HOME/.pyenv"

localrc-append 'export PYENV_ROOT="$HOME/.pyenv"'
localrc-append 'export PATH="$PYENV_ROOT/bin:$PATH"'
