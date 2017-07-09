#/usr/bin/env bash

set -euo pipefail

run_macos() {
  # Run AppStore updates
  sudo softwareupdate -i -a
  
  # Use Finder listview by default
  defaults write com.apple.Finder FXPreferredViewStyle Nlsv
  
  # Xcode command line developer tools
  xcode-select --install || true
}

run_macos
