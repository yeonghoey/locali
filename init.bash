#!/usr/bin/env bash
{

include() {
  if [[ "${LOCALISH:-}" ]]; then
    source "$1"
  else
    eval "$(curl -sL locali.sh/$1.bash)"
  fi
}

require() {
  if [[ "${LOCALISH:-}" ]]; then
    "./$1"
  else
    bash -c "$(curl -sL locali.sh/$1)"
  fi
}

}
