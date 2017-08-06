use_sudo

# Add current 'zsh' binary to /etc/shells for default shell use.
if exists_command 'zsh'; then
  info "Use zsh"
  ZSH_PATH="$(command_path 'zsh')"
  require_content '/etc/shells' "${ZSH_PATH}"
  indented \
    chsh -s "${ZSH_PATH}"
fi

info "Set locale environment variables to 'en_US.UTF-8'"
localrc 'preferences' <<EOF
export LANG='en_US.UTF-8'
export LC_ALL='en_US.UTF-8'
EOF

# macOS specific preferences
macos && {
  info "Install Xcode Command Line Tools"
  indented \
    xcode-select --install 2> /dev/null || true
}
