# configure macOS specific things {macOS}

on_macos && {
  info "Install Xcode Command Line Tools"
  xcode-select --install 2> /dev/null || true
}
