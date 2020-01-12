# stow dotfiles

# Pure theme
repo_git 'https://github.com/sindresorhus/pure.git'
localrc_zsh 'pure' << EOF

fpath+=("${LOCAL_REPOS}/pure")

EOF


stow_locali "dotfiles" "${HOME}"