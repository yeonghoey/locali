brew bundle --verbose --file=<(cat <<EOF

tap 'd12frosted/emacs-plus'
brew 'emacs-plus', args: ["--devel"]

EOF
)
