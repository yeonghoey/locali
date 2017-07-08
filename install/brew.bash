#!/usr/bin/env bash

set -euo pipefail

run_brew() {
  # Declare LOCAL_BIN
  LOCAL_BIN="${HOME}/.local/bin"
  mkdir -p "${LOCAL_BIN}"

  # Declare LOCAL_REPO
  LOCAL_REPO="${HOME}/.local/repo"; mkdir -p "${LOCAL_REPO}"
  git-repo() {
    git -C "${LOCAL_REPO}" clone "$1" || true
  }

  # Clone
  git-repo 'https://github.com/Homebrew/brew.git'

  # Add bin/brew to LOCAL_BIN
  # -i, prompt when target exists
  # -s, symbolic
  ln -is "${LOCAL_REPO}/brew/bin/brew" "${LOCAL_BIN}/brew"
}

run_brew
