#!/usr/bin/env bash

set -euo pipefail
LOCALISH="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"


if [[ "$#" != 1 ]]; then
  echo 'Usage: setup/new <name>'
  exit 1
fi

NEW_SETUP_PATH="${LOCALISH}/setup/$1"

if [[ -e "${NEW_SETUP_PATH}" ]]; then
  echo "'${NEW_SETUP_PATH}' already exists"
  exit 1
fi


cat <<'EOF' > "${NEW_SETUP_PATH}"
#!/usr/bin/env bash

set -euo pipefail
LOCALISH="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

source "${LOCALISH}/setup/init.bash"
EOF

chmod +x "${NEW_SETUP_PATH}"
