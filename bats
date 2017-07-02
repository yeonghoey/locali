#!/usr/bin/env bash

set -euo pipefail

{ # head
LOCALISH="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "${LOCALISH}/lib/core.bash"
source "${LOCALISH}/lib/git.bash"
} # end

{ # body
git-clone-or-pull \
  'https://github.com/sstephenson/bats.git' \
  "$LOCAL_REPOS/bats"

(cd "${LOCAL_REPOS}/bats"; ./install.sh "${LOCAL_ROOT}")
} # end
