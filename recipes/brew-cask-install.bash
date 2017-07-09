#/usr/bin/env bash

set -euo pipefail

run_brew_cask_install() {
  local brew="${HOME}/.local/bin/brew"
  $brew tap 'caskroom/cask'
  $brew cask install '1password'
  $brew cask install 'anki'
  $brew cask install 'betterzipql'
  $brew cask install 'docker-toolbox'
  $brew cask install 'dropbox'
  $brew cask install 'flycut'
  $brew cask install 'google-chrome'
  $brew cask install 'iterm2'
  $brew cask install 'java'
  $brew cask install 'qlcolorcode'
  $brew cask install 'qlimagesize'
  $brew cask install 'qlmarkdown'
  $brew cask install 'qlprettypatch'
  $brew cask install 'qlstephen'
  $brew cask install 'quicklook-csv'
  $brew cask install 'quicklook-json'
  $brew cask install 'slack'
  $brew cask install 'spectacle'
  $brew cask install 'visualvm'
}

run_brew_cask_install
