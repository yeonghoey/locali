# install direnv

brew bundle --verbose --file=<(cat <<EOF
brew 'direnv'
EOF
)

localrc_bash 'direnv' << 'EOF'
eval "$(direnv hook bash)"
EOF

localrc_zsh 'direnv' << 'EOF'
eval "$(direnv hook zsh)"
EOF
