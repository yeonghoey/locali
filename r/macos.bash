#/usr/bin/env bash

set -euo pipefail

run_macos() {
  # Test whether git is availvable
  # macOS will prompt to install git if not available
  git --version

  # Run AppStore updates
  sudo softwareupdate -i -a
  
  # Use Finder listview by default
  defaults write com.apple.Finder FXPreferredViewStyle Nlsv
  
  # Xcode command line developer tools
  xcode-select --install || true
}

run_macos
