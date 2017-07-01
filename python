#!/usr/bin/env bash

set -euo pipefail

SETUP_ENV="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

source "${SETUP_ENV}/lib/git.sh"
source "${SETUP_ENV}/lib/localrc.sh"

git-clone-or-pull 'https://github.com/pyenv/pyenv.git' "$HOME/.pyenv"

append-localrc 'export PYENV_ROOT="$HOME/.pyenv"'
append-localrc 'export PATH="$PYENV_ROOT/bin:$PATH"'
append-localrc 'eval "$(pyenv init -)" # should be placed at very last'
