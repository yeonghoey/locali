#!/usr/bin/env bash

set -euo pipefail

run_brew() {
  git-repo 'https://github.com/Homebrew/brew.git'

  # Add bin/brew to LOCAL_BIN
  # -i, prompt when target exists
  # -s, symbolic
  ln -is "${LOCAL_REPO}/brew/bin/brew" "${LOCAL_BIN}/"
}

run_brew
