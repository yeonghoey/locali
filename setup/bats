#!/usr/bin/env bash
{
set -euo pipefail
eval "$(curl -sL locali.sh/init)"

include 'core'

gitrepo 'https://github.com/sstephenson/bats.git'

"${LOCAL_REPO}/bats/install.sh" "${LOCAL_ROOT}"
}
