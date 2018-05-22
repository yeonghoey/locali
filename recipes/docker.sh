# 1. Install docker-toolbox ('docker-machine' included)
brew bundle --verbose --file=<(cat <<EOF

tap 'caskroom/cask'
cask 'docker-toolbox'

EOF
)

docker-machine create --driver virtualbox default || true

localrc 'docker' << 'EOF'
if [[ -z "${DOCKER_HOST}" ]]; then
  docker-machine start default || true
  eval $(docker-machine env default)
fi
EOF
