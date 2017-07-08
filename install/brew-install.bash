#/usr/bin/env bash

set -euo pipefail

run_brew_install() {
  # Declare LOCAL_BIN
  LOCAL_BIN="${HOME}/.local/bin"
  mkdir -p "${LOCAL_BIN}"

  # Add LOCAL_BIN to PATH
  if [[ ":${PATH}:" != *":${LOCAL_BIN}:"* ]]; then
    PATH="${LOCAL_BIN}:${PATH}"
  fi 
  
  brew update

  brew install 'cmake'
  brew install 'diff-so-fancy'
  brew install 'fasd'
  brew install 'fpp'
  brew install 'gawk'
  brew install 'git'
  brew install 'git-extras'
  brew install 'git-lfs'
  brew install 'go'
  brew install 'hub'
  brew install 'imagemagick'
  brew install 'ispell'
  brew install 'node'
  brew install 'readline'
  brew install 'the_silver_searcher'
  brew install 'tmux'
  brew install 'wget'
  brew install 'xz'
}

run_brew_install
