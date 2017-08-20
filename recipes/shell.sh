# configure shell preferences; use zsh

info "Set locale environment variables to 'en_US.UTF-8'"

localrc 'shell' <<EOF
export LANG='en_US.UTF-8'
export LC_ALL='en_US.UTF-8'
EOF

# ------------------------------------------------------------------------------

info "Use zsh"

ZSH_PATH="$(command_path 'zsh')"
require_content '/etc/shells' "${ZSH_PATH}"
chsh -s "${ZSH_PATH}"
