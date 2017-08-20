# configure macOS specific things | (macos)

on_macos && {
  info "Install Xcode Command Line Tools"
  xcode-select --install 2> /dev/null || true
}
