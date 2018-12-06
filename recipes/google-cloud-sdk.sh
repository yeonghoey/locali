# install google-cloud-sdk
brew bundle --verbose --file=<(cat <<EOF

tap 'caskroom/cask'
cask 'google-cloud-sdk'

EOF
                              )

readonly GOOGLE_CLOUD_SDK="$(brew --prefix)/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/"

localrc_bash 'google-cloud-sdk' << EOF
source '${GOOGLE_CLOUD_SDK}/path.bash.inc'
source '${GOOGLE_CLOUD_SDK}/completion.bash.inc'
EOF

localrc_zsh 'google-cloud-sdk' << EOF
source '${GOOGLE_CLOUD_SDK}/path.zsh.inc'
source '${GOOGLE_CLOUD_SDK}/completion.zsh.inc'
EOF

localrc 'google-cloud-sdk' << EOF
export CLOUDSDK_PYTHON="$(pyenv which python2)"
EOF
