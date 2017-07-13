#!/usr/bin/env bash
{

include() {
  if [[ "${LOCALISH:-}" ]]; then
    source "include/$1.bash"
  else
    eval "$(curl -sL locali.sh/include/$1.bash)"
  fi
}

require() {
  if [[ "${LOCALISH:-}" ]]; then
    "./$1"
  else
    bash -c "$(curl -sL locali.sh/$1)"
  fi
}

export LOCAL_ROOT="${HOME}/.local"
export LOCAL_REPO="${LOCAL_ROOT}/repo"
export LOCAL_BIN="${LOCAL_ROOT}/bin"
export LOCALRC="${HOME}/.localrc"

mkdir -p "${LOCAL_ROOT}"
mkdir -p "${LOCAL_REPO}"
mkdir -p "${LOCAL_BIN}"
touch "${LOCALRC}"

export PATH="${LOCAL_BIN}:${PATH}"
localrc() {
  local content="$(cat -)"
  if ! grep -q "${content}" "${LOCALRC}"; then
    echo "$content" >> "${LOCALRC}"
  fi
}

localrc <<- EOF
  export PATH="$(homepath ${LOCAL_BIN}):\${PATH}"
EOF
}
