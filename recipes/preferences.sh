use_sudo

# Add current 'zsh' binary to /etc/shells for default shell use.
if exists_command 'zsh'; then
  ZSH_PATH="$(command_path 'zsh')"
  require_content '/etc/shells' "${ZSH_PATH}"
  chsh -s "${ZSH_PATH}"
fi

localrc 'preferences' <<EOF
export LC_ALL='en_US.UTF-8'
EOF

# macOS specific preferences
macos && {
  xcode-select --install || true
}
