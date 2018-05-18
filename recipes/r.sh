brew bundle --verbose --file=<(cat <<EOF

tap 'caskroom/cask'
brew 'r'
cask 'rstudio'

EOF
)

defaults write org.R-project.R force.LANG 'en_US.UTF-8'
